import { createRouter, createWebHistory } from 'vue-router';

const routes = [
  {
    path: '/',
    component: () => import('@/layouts/BerandaLayout.vue'),
    children: [
      { path: '', component: () => import('@/pages/index.vue') },
      { path: 'produk-hukum', component: () => import('@/pages/produk-hukum.vue') },
      { path: 'berita', component: () => import('@/pages/berita.vue') },
      {
        path: 'berita/:slug',
        name: 'BeritaDetail',
        component: () => import('@/pages/berita-detail.vue'),
        props: true,
      },
      { path: 'layanan', component: () => import('@/pages/layanan.vue') },
      { path: 'galeri', component: () => import('@/pages/galeri.vue') },
      { path: 'kontak', component: () => import('@/pages/kontak.vue') },
      { path: 'profil/tentang-pkp', component: () => import('@/pages/profil/tentang-pkp.vue') },
      { path: 'profil/tugas-pokok-dan-fungsi', component: () => import('@/pages/profil/tugas-pokok-dan-fungsi.vue') },
      { path: 'profil/visi-dan-misi', component: () => import('@/pages/profil/visi-dan-misi.vue') },
      { path: 'profil/struktur-organisasi', component: () => import('@/pages/profil/struktur-organisasi.vue') },
      { path: 'profil/profil-pegawai', component: () => import('@/pages/profil/profil-pegawai.vue') },      
      { path: 'aspirasi', component: () => import('@/pages/aspirasi.vue') },    
      { path: 'login', component: () => import('@/pages/login.vue') },      
    ],
  },
  {
    path: '/pkp-lamandau',
    component: () => import('@/layouts/AdminLayout.vue'),
    children: [      
      { path: 'home', component: () => import('@/pages/admin/home.vue') },      
      { path: 'pengelolaan-beranda', component: () => import('@/pages/admin/beranda.vue') },
      { path: 'data-pegawai', component: () => import('@/pages/admin/data-pegawai.vue') },
      { path: 'struktur-organisasi', component: () => import('@/pages/admin/struktur-organisasi.vue') },
      { path: 'pengelolaan-layanan', component: () => import('@/pages/admin/layanan.vue') },
      { path: 'pengelolaan-produk-hukum', component: () => import('@/pages/admin/produk-hukum.vue') },
      { path: 'pengelolaan-berita', component: () => import('@/pages/admin/berita.vue') },
      { path: 'pengelolaan-galeri', component: () => import('@/pages/admin/galeri.vue') },
      { path: 'pengelolaan-aspirasi', component: () => import('@/pages/admin/aspirasi.vue') },
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
