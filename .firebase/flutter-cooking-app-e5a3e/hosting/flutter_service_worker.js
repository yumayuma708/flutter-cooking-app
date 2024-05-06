'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "04b62c4fe9d2a19d447934528da1ad22",
"index.html": "8a119f54c8391c6c4db139c0a3982314",
"/": "8a119f54c8391c6c4db139c0a3982314",
"main.dart.js": "9226a29e8f00d47482c6e07960058839",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "78dd7390797f0165f211984da3422acf",
"assets/terms_and_conditions.md": "127414e8398a78677f8efab5fbf8328c",
"assets/privacy_policy.md": "1b81a1c4a32160815c43dcb45272da4e",
"assets/images/icon.jpg": "a1da65863e32491ecaa5b097e978aeee",
"assets/images/salt.png": "5bb6b6ad30a62475a4d7a9bb3fc87005",
"assets/images/renew.png": "6e2568e69c1cb8c3fee979d82f179408",
"assets/images/meat.png": "3cabbfa1691270228cf4cdd46c29d957",
"assets/images/rice.png": "6f89785aacfd2be1898bf44e66586716",
"assets/images/curry.png": "498b0a5aa480b884d9171ab2ff192bea",
"assets/images/knife.png": "73cbdcfd0a3536160556efd44dc1fe4b",
"assets/images/fruit.png": "0f2286dc56e4c0fb439484f8b3170891",
"assets/AssetManifest.json": "3253d3cb0bc50662259ed143f617dbe8",
"assets/NOTICES": "35cab40d0173cdec8909498729c0fdde",
"assets/FontManifest.json": "40ab48ce09df0b35447184db2a2a4a05",
"assets/AssetManifest.bin.json": "85f3b68d181b9b4d0f75d17063a0bc92",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e14d4247c0221552f79bf5629127cff4",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "00f53a81aaeea59551f75098227e6e72",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "60d2970c525f75751d86b0147e44348a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "17ee8e30dde24e349e70ffcdc0073fb0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ea7200a192f621dcf829a86b655c4915",
"assets/fonts/ZenKakuGothicNew-Bold.ttf": "a421598d8bd036ef6aa53afd7d69a212",
"assets/fonts/ZenKakuGothicNew-Regular.ttf": "8b87592531f42ab43e12b2f0b97f2381",
"assets/fonts/MaterialIcons-Regular.otf": "e34a6bb3b2b50e34652aae769a834390",
"assets/assets/terms_and_conditions.md": "127414e8398a78677f8efab5fbf8328c",
"assets/assets/privacy_policy.md": "1b81a1c4a32160815c43dcb45272da4e",
"assets/assets/images/icon.jpg": "a1da65863e32491ecaa5b097e978aeee",
"assets/assets/images/salt.png": "5bb6b6ad30a62475a4d7a9bb3fc87005",
"assets/assets/images/renew.png": "6e2568e69c1cb8c3fee979d82f179408",
"assets/assets/images/meat.png": "3cabbfa1691270228cf4cdd46c29d957",
"assets/assets/images/rice.png": "6f89785aacfd2be1898bf44e66586716",
"assets/assets/images/curry.png": "498b0a5aa480b884d9171ab2ff192bea",
"assets/assets/images/knife.png": "73cbdcfd0a3536160556efd44dc1fe4b",
"assets/assets/images/fruit.png": "0f2286dc56e4c0fb439484f8b3170891",
"assets/assets/fonts/ZenKakuGothicNew-Bold.ttf": "a421598d8bd036ef6aa53afd7d69a212",
"assets/assets/fonts/ZenKakuGothicNew-Regular.ttf": "8b87592531f42ab43e12b2f0b97f2381",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
