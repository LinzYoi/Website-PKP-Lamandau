import { createRouter, createWebHistory } from 'vue-router';

const routes = [
  {
    path: '/',
    component: () => import('@/layouts/AuthLayout.vue'),
    children: [
      { path: '', component: () => import('@/pages/index.vue') },
      { path: 'login', component: () => import('@/pages/login.vue') },      
    ],
  },
  {
    path: '/pkp-lamandau',
    component: () => import('@/layouts/MainLayout.vue'),
    children: [      
      { path: 'home', component: () => import('@/pages/home.vue') },      
      { path: 'pengelolaan-beranda', component: () => import('@/pages/beranda.vue') },
      { path: 'data-pegawai', component: () => import('@/pages/data-pegawai.vue') },
      { path: 'struktur-organisasi', component: () => import('@/pages/struktur-organisasi.vue') },
      { path: 'pengelolaan-layanan', component: () => import('@/pages/layanan.vue') },
      { path: 'pengelolaan-produk-hukum', component: () => import('@/pages/produk-hukum.vue') },
      { path: 'pengelolaan-berita', component: () => import('@/pages/berita.vue') },
      { path: 'pengelolaan-galeri', component: () => import('@/pages/galeri.vue') },
      { path: 'pengelolaan-aspirasi', component: () => import('@/pages/aspirasi.vue') },
    ],
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition;
    } else {
      return { top: 0 };
    }
  }
});


export default router;
