'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "bf906b4b508d573aabff24539562446b",
"assets/assets/copy.png": "3581120452344a543355db8fa93d022e",
"assets/assets/close-ic.png": "b5b11103e963681f74c46aa379520345",
"assets/assets/back-ic.png": "636e654e7008c1e1269b01e3df958d35",
"assets/assets/add.png": "ec0b9878e2d28a2c596ba3c23a102455",
"assets/assets/status3.png": "62527f835fa26a09a3e66139f126c534",
"assets/assets/token_abi.json": "103480343dab65c40c59873729a4ebb3",
"assets/assets/list-ic.png": "915159f8b1df2f1b4feff9573846d1e7",
"assets/assets/status4.png": "33c617f4d4937cf770ddd8bfac1f2509",
"assets/assets/status2.png": "580902bb6bff9e053347847734fb67c5",
"assets/assets/wallet-ic.png": "162174739ecc618e103a0f1cf2bf6eb6",
"assets/assets/send.png": "0395bd41de1915c040a5d1fed18fdc2f",
"assets/assets/status0.png": "b03d6aff411ff53eadf87582709d9941",
"assets/assets/transfer-ic.png": "0cde96decaa596698b33dac6808149cf",
"assets/assets/save-ic.png": "acb5120f45fe35af1e39bbe161d440ac",
"assets/assets/status1.png": "2e9226d050c0a93b4ad8148a1a1e2bd6",
"assets/assets/arrow-send.png": "728a24a8ea19b0849c2df317b7738128",
"assets/assets/profile-ic.png": "1b699cb4be7705673ea61639759f36b3",
"assets/assets/edit.png": "2d89d67f2173b4ec5a743fce5738da73",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flutter_neumorphic/fonts/NeumorphicIcons.ttf": "32be0c4c86773ba5c9f7791e69964585",
"assets/FontManifest.json": "8a36aef7019e24540ab6c2438a7fedf2",
"assets/AssetManifest.json": "d3f46488a0612787b16589c9441fc319",
"assets/NOTICES": "412a199f93823e621a0ea41a9d460ded",
"assets/fonts/EvolveSans-Regular.otf": "11ea6b4ff0e6b93c9894b4173f9703b0",
"assets/fonts/EvolveSans-Bold.otf": "b67726ebc3b43b524cf04c36c76899fa",
"assets/fonts/EvolveSans-Light.otf": "c30c70e32046550a163b1b9ac09d52b7",
"assets/fonts/EvolveSans-Medium.otf": "2f45fde7abeba87c8eddbb1e03e429c3",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"index.html": "70d39640840cb7c1bb5f63e18d576ccf",
"/": "70d39640840cb7c1bb5f63e18d576ccf",
"manifest.json": "7c4cde176460b5270b43eddd55140fbf",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"version.json": "34f09d0b97ffcb23006117d8e2131e55",
".git/COMMIT_EDITMSG": "8cf8463b34caa8ac871a52d5dd7ad1ef",
".git/config": "001ee44fea7c47022cd14fa9bbd141ae",
".git/ORIG_HEAD": "dbb3094bc5e439421a9e764434369089",
".git/index": "93e4d62eff1d985fa20f7d9fabb40429",
".git/objects/ec/85723cef3c1ef45b55afd848f13282aaa1a599": "28f88ec51987eaa99ee0f487c8c5332c",
".git/objects/98/a81adc187f732cfb8c4d6b7f16cb50d8831012": "4bf6079326896c51cdeaa8b16b35d4d3",
".git/objects/c2/82762e8db4fdf781e79a71dfe8da50cf02b7d9": "e9e751c19f57ab71a6ad1baceb8c2fa1",
".git/objects/20/5bb5db271c6d8de8399864c7bb9b917f638893": "c993b22f115d7f3ae6d5b7b212806539",
".git/objects/a1/3837a12450aceaa5c8e807c32e781831d67a8f": "bfe4910ea01eb3d69e9520c3b42a0adf",
".git/objects/fe/81c8f8ce38781459eb0346f37cae0662d9b704": "19986d2558e6b62b729a41a431bf0ba6",
".git/objects/e0/ae13151add5c624e0a0991896d7f205838d4d9": "d5442f174bf4762ad240b431f2882bee",
".git/objects/23/5092165fe23cb211c159dbad525c668d3ec9ab": "d6f1d38267db7f5dcd2f0251b944c5ee",
".git/objects/a5/ed5444b0c7d1a809efb3c641705cca1ec91b8f": "f3be88568a11403b9e5e8b26ec6a5871",
".git/objects/c4/a94e1b1fb87270be8bdb7aa84e2104dd16f5cf": "f063ba963a54564e96f2671dbfcf546e",
".git/objects/8e/5f6be902545a0612162e937efd202c72c13902": "689eeac863e78d31185182efc2760e7e",
".git/objects/7c/66eb111eca78e690fd8954a09f17553df4d6f0": "6c7295fefdce7d5a1c1b3aa5aed71bc6",
".git/objects/85/dbdfdeb1199e9d434bca4e43f2c57eee919cb6": "0449b718565186c6d00d2ef4bd40dff1",
".git/objects/15/f6526fde52dec610f72cfa834a869d26cf45ee": "97b4543bd6378c81c3898c3cbaedc79a",
".git/objects/2c/c1d72405ee86912911b498e52f3d86b4a2472b": "5adf273422aff45586598b4314435c3a",
".git/objects/d7/2ec28591d09dfef6fc1fae5cafd2cf0b6ff075": "6de7e3abdf03658625da8e17f288c48c",
".git/objects/8f/801322e1176eca57f748a7e2a562b17043e46e": "0cb804794468668213fdd9f5876ee594",
".git/objects/8f/1258b41f2e406b5780c977700fdd2772c4cda1": "eb71c7ac2e5e9be2be0501325385b338",
".git/objects/3b/b6e6fff142b1056c95c2edc96d352022616ccc": "797551dbaa34aae2df0356d636a0774e",
".git/objects/a2/c8860ae922d7a0d24ffac0384adb5b00bca43c": "e5a390cc838077f59fab775afac19634",
".git/objects/a2/d837dccd689a3cd7715a2440b44b9b23e71272": "3df6a53641db2c5a6822acc9a5161b98",
".git/objects/57/7747d8ef922aff3a18481475c844f87f73f966": "9ba17f8f36e9be3a4c53f5b439e55305",
".git/objects/41/b2c69b72897733c021e74e8ec6ed0f63c61cb5": "80627df27e1586aa51b130e3ab5c4ea4",
".git/objects/0a/966f145d379d137228a64d286a39e24d91d07c": "4aeb660e3abf36e3dba3fbdd31a12237",
".git/objects/96/3d4cf14d56bca8d1d4f37d5c771f5b4aab8a9f": "1f538491aedbe504404231fe6df6b801",
".git/objects/d8/4d4cebfdf81367aadaa96c7f6e84bda2b89f11": "0ef82a58236b7751ef657a82b9abf409",
".git/objects/3d/d0d9bb81126d9e5a184db75e4583da211f62f6": "b4ef462f1053784c137f8fb6ffd4b0ac",
".git/objects/92/8f9654e651855d2e4e6543a363963bd0f7429d": "7fccb40bcbccf649b45dd9aea28ea8e4",
".git/objects/09/db2e5c6e1ec33d7bb9d7b7c2150e43f26a1464": "3af7adef381442ecff6b5556275db85c",
".git/objects/ee/09c91b3d78f264c0372f95e28bf403f3dacae4": "4d3167a88600bf2841627671d22927da",
".git/objects/60/7d9d8aebd92ceb69cf4331ceda850f73579702": "af87fd71fdc55db2f67784294e9bfc88",
".git/objects/f2/ebd4dc78f2862bb5fd722152c2e08b71273cf2": "910b2bdf0ef6ed9b5937c4c995411d4a",
".git/objects/77/9d9098d42a0ad7ecd8e4f65f68c77b929243cb": "e6a87f9c472d2ede1d0ab806fd4c0091",
".git/objects/81/54639eab62aa5051ac37992e85bc6901743b7e": "d6ef5e08b0fe475d4dee2b8424e689d8",
".git/objects/00/524a704b467c966ac23c590f3f3e08e9dbe266": "72e938181cf6a1b3fe45ef845373de32",
".git/objects/b6/e4c4fb340825b7568bdb8e1d0904c047b2c944": "9485b1b9a42d143cd9f847784c77cda3",
".git/objects/b6/f01c9352d6e83348c7e0d8dff9d452e0da9550": "2d32b55b3b421a42d7b25d74f6e753fa",
".git/objects/74/472b37d29a610f935304f26fa3d053d02d1869": "27bee54326455a453bd6731ebf069a0c",
".git/objects/a8/d0419083e84fb7441d9228aa99364a30388a9b": "c9dce04b5b16da0a422fe89358f9d5c6",
".git/objects/a8/3a17d54b6dc2156c855c6580301cefc9c8d017": "6525101be8d70b808a809af9c83fa4ad",
".git/objects/a8/444dd552edd12eba3c9b4617b2993d642b98ca": "b5ea7b4f1fe761090cfd58764151bbb7",
".git/objects/52/b9954230cbf77e500cdc1275f44ebd592441bd": "b77c12fcd8c2b0c4d1c9d2139d950b9c",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/66/872c603528ac7a2df8b8a351f7ab4d1e84d548": "50da38711015389e32102fd6e5b63ff9",
".git/objects/32/8f4e6dbfe1b80e1d8899970fe93412837df632": "fe236b98494169a6371602fcfea88b2b",
".git/objects/32/986ee6f2ebf89c9ffc8afaa708f3c7f310f127": "1fdc7010383227c71ff6ad0f8f2ba715",
".git/objects/a4/570af582a9cc0051ce3aee79b3c3cf45e06b57": "ae56ebd33400fc8118d7332405bc3c81",
".git/objects/cc/8e224631d8165f84d80594563f41a1fa182b77": "2feb2c493090959b6564d5cd84f5fa31",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/5b/2b41c2ef5e63bb6a135cc31ceb7f0867aefc7a": "c56188816dd1886415217cd3ccc9100a",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8a/81af533f5f1ba3d0864e3a6dd4d48022090588": "9d93f3f244596abcf87b8cf0c836f47a",
".git/objects/54/371f3439c4aae431e4df30b223c3d7396c7628": "ac40e877bb470c0b97ec5c76fe98fe54",
".git/objects/61/9b5f63d0d406535b2a96c45f7eafb75f47a068": "073936216a043b69ed4305f7560bd7e5",
".git/objects/e5/10e034a122814c725219af322e641e18b09e60": "a91f82cefe87f26dd22880164d3a8b6a",
".git/objects/e5/951dfb943474a56e611d9923405cd06c2dd28d": "c6fa51103d8db5478e1a43a661f6c68d",
".git/objects/9b/54f4aac525c34c5e3094672e5e6b754617655d": "c6ab87b693710a09e1f2641813fedc42",
".git/objects/b4/9e66af354a0f5605520133c400bf90a29dc44f": "47450f5154acc6a5614b97d9c2a86067",
".git/objects/6c/cc2cb773bfda8bede00484c91c7bd6ad7388ea": "89982c6018487015e6df2b9ca93bcafd",
".git/objects/12/78e84628fa8552c2780d3399491b7f4608f1a4": "e51db8b5c8cf613893f51405e8c4657c",
".git/objects/ab/71e57191c1c85c055eccc83169d3d598ebf4ed": "3fbd266be4980a70b9531c7f10546869",
".git/objects/97/d57a70d9a8bae8531fbccb33e0b0377ac4cf14": "e1e80f6c04b22b098af5e44d265a41a1",
".git/objects/19/7a8f0880e5a9dead4449779a79a4c7ace95ec5": "6c62bc2fbda2d01db4bd1eb27ee233bc",
".git/objects/6f/c407deb19629858c29ee0fd61f8d07150aed76": "fe4eca85cf6f3868bd63828fde4da6b9",
".git/objects/6f/d0b0c38ac2753f045dfaaaecd108bdb688cfc5": "bcbaf104e65f6f683853b0a6814bd5bb",
".git/objects/a7/3ec246a716efe5a6abf978b20922f7ba263aef": "17ad911abf4e9a5ee32d413305ff442f",
".git/objects/48/7a8ab91971e38b6e1fd7b377e2fde78b177abd": "49c1ef6dee9d929f1a7effffa90275b5",
".git/objects/93/7e01f7c59a88565b0abcabcca2a68e55de8cc1": "232477654ae972c17ae9cc2fec868c0a",
".git/objects/6d/8e8d9b30b1fedda4def21ff353627da707691a": "420c10160f9380307c04c397ce44a67a",
".git/objects/95/8f62e40c96100872fee199d6324e593e60f54b": "2ff28c5192a5897e247528fd857fedcf",
".git/objects/14/4e5a9abb1cb6fde96956ed26c7e3f5a3fff097": "28ba2b02f8479b72e59ca81f3c05b29a",
".git/objects/14/5badbc9f280f6dd0a306f590b3511831537371": "56a2641ea6d1c843c9d224473d597e10",
".git/objects/5c/9af797a620a66746750868f08073ecc04f1f9b": "74e95d976e5985f4b9213653c27e1d05",
".git/objects/18/aaf2a3f967c4857aec767417f0766cb987334d": "bcb62ddc994f4541ac8fa45ee2e436f8",
".git/objects/29/38de035f45a62d603a0da36f80f21c3ad23329": "6b613ea7742a5df26ac4e8d98a058f6d",
".git/objects/ff/a83da82552938e6006a57d29e6a5d206e1bd55": "4ab5a636d9a1cb28f7ee6cd86effbfad",
".git/objects/28/ff212cf071c796156f5721c96f3295481c1ba7": "fefd8320ed4a75f4ebfd998d7a149bab",
".git/objects/79/ba7ea0836b93b3f178067bcd0a0945dbc26b3f": "f3e31aec622d6cf63f619aa3a6023103",
".git/objects/4a/18cb31d344393c7301630065d31dc7b23deb07": "e3c7455e034c17b68b6168ccc1a9da87",
".git/objects/75/dccf3156f77002f47e39d90de32d41645f7e32": "41c9684a59b97a88f8b4e45d6f24e6bf",
".git/objects/d2/d8b258b7b4097ff2488e5127228cf93cd121c1": "73008e4aa7cb8ae76bda73eb314aeb0c",
".git/objects/bf/aaed8d8de3b2550ce8a86460ed3bb9d77d8326": "fb42975ff5fb97982e2a644b632f519d",
".git/logs/HEAD": "b2daee96023329352803e92c9f0e0336",
".git/logs/refs/remotes/origin/master": "e7a3f8042a4728010f834e8f931e1fc0",
".git/logs/refs/heads/master": "b2daee96023329352803e92c9f0e0336",
".git/FETCH_HEAD": "a29fe2f5a3d25c87bf1663a4bacc837a",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/hooks/pre-commit.sample": "e4db8c12ee125a8a085907b757359ef0",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/pre-push.sample": "3c5989301dd4b949dfa1f43738a22819",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/update.sample": "517f14b9239689dff8bda3022ebd9004",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "db4d62db2039e4bec38baa7567788284",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/refs/remotes/origin/master": "8428e80a9e5670226f1a13b13677631e",
".git/refs/heads/master": "8428e80a9e5670226f1a13b13677631e",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
"CNAME": "14712589c7f5f75735bbf994a7fd1cc1"
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
