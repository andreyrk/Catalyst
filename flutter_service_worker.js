'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "f941bceec698c2139ee43f2f5e973a63",
"/": "f941bceec698c2139ee43f2f5e973a63",
"main.dart.js": "961018818dc93913c08219475a774b0e",
"version.json": "85c5f296b02773bf01d716e97e7e39d7",
"icons/Icon-192.png": "daae576f20892dc36e776da5eb9898cd",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.json": "6712c5caf1dfea99c9926162637a91d9",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/rsc/locale/en.json": "89c6bb9adbf10628cdd10bed2c8ef3c5",
"assets/rsc/locale/pt.json": "3ab693a802aea2ea23f49fa8d8e1f809",
"assets/rsc/courses/enem/redacao.json": "744d8ba2cdf5c9368480b6cf1a557811",
"assets/rsc/courses/enem/filosofia.json": "2adbe5ac54f0a0aecfe7fb500b438e06",
"assets/rsc/courses/enem/quimica.json": "12122319bcdfc01b16e865d077e6abdd",
"assets/rsc/courses/enem/espanhol.json": "bb9a0561897678a1cc167810764e86de",
"assets/rsc/courses/enem/literatura.json": "b0453e6b1f88b7d37691970dbf58fe23",
"assets/rsc/courses/enem/artes.json": "dbd6bf68d54af2074903685514d3e844",
"assets/rsc/courses/enem/matematica.json": "9b163568a95ad9a7d6523d02b1e1019c",
"assets/rsc/courses/enem/atualidades.json": "b7dc1f0ff7dc321466419ab0e628e1d3",
"assets/rsc/courses/enem/fisica.json": "7f22796057e7a72c4f51d9fdbda3ce62",
"assets/rsc/courses/enem/historia.json": "1b14d4aefaff9debf4ccbef30a08dbbe",
"assets/rsc/courses/enem/sociologia.json": "7ad2fb2aee47c9ac7d4496fb8fa766d3",
"assets/rsc/courses/enem/biologia.json": "d74459259d8d0620bdb1a97e4060dcf7",
"assets/rsc/courses/enem/matematica_basica.json": "01b0f23d5648d31029a08e85cdf89c6d",
"assets/rsc/courses/enem/portugues.json": "7885c95f64edb707afbc673e9b249084",
"assets/rsc/courses/enem/geografia.json": "7b2909bc2a269fcae30a869ffd55636a",
"assets/rsc/courses/enem/ingles.json": "5616bb2399b71ddb2ecb4834121e1c6d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/NOTICES": "b8e57ddc45702530ef41572d4b43ad32",
"manifest.json": "82ace3be54cdab4b5f89b8ac7fbbfb8d",
"favicon.png": "6f6f77a9546950a366b83b5467dec732"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
