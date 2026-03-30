const CACHE_NAME = 'jerman-lindav-v1';
const OFFLINE_ASSETS = [
  '/',
  '/index.html',
  '/css/styles.css',
  '/js/main.js',
  '/pages/about.html',
  '/pages/blog.html',
  '/pages/careers.html',
  '/pages/contact.html',
  '/pages/download.html',
  '/pages/help.html',
  '/pages/press.html',
  '/pages/privacy.html',
  '/pages/signin.html',
  '/pages/signup.html',
  '/pages/terms.html',
  '/images/ChatGPT Icon.png',
  '/images/ChatGPT Image1.png',
  '/images/ChatGPT Image2.png',
  '/images/ChatGPT Image3.png',
  '/images/phone1.png',
  '/images/phone2.png',
  '/images/phone4.png',
  '/images/phone5.png'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(OFFLINE_ASSETS))
  );
  self.skipWaiting();
});

self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames =>
      Promise.all(
        cacheNames
          .filter(cacheName => cacheName !== CACHE_NAME)
          .map(cacheName => caches.delete(cacheName))
      )
    )
  );
  self.clients.claim();
});

self.addEventListener('fetch', event => {
  const request = event.request;

  if (request.method !== 'GET') {
    return;
  }

  const requestUrl = new URL(request.url);

  if (requestUrl.origin !== self.location.origin) {
    return;
  }

  if (requestUrl.pathname.startsWith('/downloads/')) {
    return;
  }

  event.respondWith(
    caches.match(request).then(cachedResponse => {
      if (cachedResponse) {
        return cachedResponse;
      }

      return fetch(request)
        .then(networkResponse => {
          const responseToCache = networkResponse.clone();
          caches.open(CACHE_NAME).then(cache => cache.put(request, responseToCache));
          return networkResponse;
        })
        .catch(() => caches.match('/index.html'));
    })
  );
});
