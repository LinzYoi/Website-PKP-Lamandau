<template>
  <v-responsive>
    <v-app>
      <NavigationBeranda />

      <v-main style="margin-top: 280px">
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <v-row align="center">
                <v-col cols="12" v-if="berita">
                  <h2 class="text-h4 font-weight-bold mb-4">
                    {{ berita.judul_berita }}
                  </h2>
                  <p class="text-body-1 text-caption mb-6">
                    {{ formattedDate(berita.tanggal_berita) }}
                  </p>
                  <div class="mb-8 mx-14">
                    <v-img
                      :src="`${baseUrl}/storage/${berita.file_gambar_berita}`"
                      width="100%"
                      height="auto"
                      class="rounded-xl"
                      cover
                    />
                  </div>
                  <p class="text-body-1 text-justify">
                    {{ berita.deskripsi_berita }}
                  </p>

                  <h2 class="text-h5 font-weight-bold mt-12 mb-4">
                    Berita Lainnya
                  </h2>

                  <v-row
                    v-for="berita in beritaStore.beritas"
                    :key="berita.id"
                    align="center"
                    justify="center"
                  >
                    <v-col cols="12">
                      <v-card elevation="0" tile @click="goToDetail(berita)">
                        <v-row align="center">
                          <v-col cols="10">
                            <p class="text-h6 font-weight-bold">
                              {{ berita.judul_berita }}
                            </p>
                            <p class="text-body-1 font-weight-medium">
                              {{ formattedDate(berita.tanggal_berita) }}
                            </p>
                            <p class="text-body-1 mt-4">
                              {{ berita.deskripsi_berita }}
                            </p>
                          </v-col>
                          <v-col cols="2" class="pa-7">
                            <v-card
                              :elevation="0"
                              color="bg-transparent"
                              rounded="xl"
                              class="d-flex flex-column justify-space-between"
                            >
                              <v-img
                                :src="`${baseUrl}/storage/${berita.file_gambar_berita}`"
                                height="150"
                                cover
                              ></v-img>
                            </v-card>
                          </v-col>
                        </v-row>
                      </v-card>
                    </v-col>
                  </v-row>
                </v-col>

                <v-col cols="12" v-else>
                  <p class="text-center text-body-1">Berita tidak ditemukan.</p>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-container>
      </v-main>

      <v-footer
        class="text-center d-flex flex-column py-16 px-16"
        color="#FFD95F"
        style="margin-top: 110px"
      >
        <div class="d-flex ga-3">
          <v-btn
            v-for="icon in icons"
            :key="icon"
            :icon="icon"
            density="comfortable"
            variant="text"
          ></v-btn>
        </div>

        <v-row align="center" justify="center">
          <v-col cols="5" class="d-flex align-center pe-12">
            <!-- gambar -->
            <v-img
              src="/logo_pkp_lamandau.png"
              width="50"
              height="auto"
            ></v-img>
            <p class="ms-4 text-body-1 text-justify font-weight-bold">
              Bidang Perumahan dan Kawasan Permukiman (PKP) Dinas PUPR PERKIMTAN
              Kabupaten Lamandau
            </p>
          </v-col>
          <v-col cols="5" class="ps-12">
            <p class="text-body-1 font-weight-medium text-justify">
              RC7M+P9V, Komplek Perkantoran PEMDA Bukit Hibul, Prov., Nanga
              Bulik, Kec. Bulik, Kabupaten Lamandau, Kalimantan Tengah 74161
              Telp : 0281 122143147931
            </p>
          </v-col>
        </v-row>

        <div class="mt-14">
          <span class="text-caption"
            >Copyright © Bidang Perumahan dan Kawasan Permukiman (PKP) Dinas
            PUPR PERKIMTAN Kabupaten Lamandau 2025</span
          >
        </div>
      </v-footer>
    </v-app>
  </v-responsive>
</template>

<script setup>
import NavigationBeranda from "@/components/NavigationBeranda.vue";

import { ref, onMounted, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import config from "../../config";
import { useBeritaStore } from "@/stores/berita";

const router = useRouter();
const route = useRoute();
const beritaStore = useBeritaStore();
const baseUrl = config.baseUrl;

const slug = ref(route.params.slug || "");
const berita = ref(null);

const formattedDate = (date) => {
  const options = {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  }
  return new Date(date).toLocaleDateString("id-ID", options);
};

const profilItems = ref([
  { title: "Tentang PKP", to: "/profil/tentang-pkp" },
  { title: "Tugas Pokok dan Fungsi", to: "/profil/tugas-pokok-dan-fungsi" },
  { title: "Visi & Misi", to: "/profil/visi-dan-misi" },
  { title: "Struktur Organisasi", to: "/profil/struktur-organisasi" },
  { title: "Profil Pegawai", to: "/profil/profil-pegawai" },
]);

const slugify = (text) => {
  return text
    .toString()
    .toLowerCase()
    .trim()
    .replace(/\s+/g, '-')        // spasi → dash
    .replace(/[^\w\-]+/g, '')    // hilangkan karakter non-word
    .replace(/\-\-+/g, '-')      // ganti multiple dash jadi satu
    .replace(/^-+/, '')          // hapus dash di awal
    .replace(/-+$/, '');         // hapus dash di akhir
};

const goToDetail = (berita) => {
  const slug = slugify(berita.judul_berita);
  router.push(`/berita/${slug}`);
};

watch(
  () => route.params.slug,
  async (newSlug) => {
    slug.value = newSlug;
    await fetchDetail(newSlug);
  }
);

const fetchDetail = async (currentSlug) => {
  // Pastikan data list beritas sudah terisi
  if (beritaStore.beritas.length === 0) {
    await beritaStore.getAllBeritas();
  }
  // Cari data berdasarkan slug
  berita.value = beritaStore.getBeritaBySlug(currentSlug);

  if (!berita.value) {
    console.warn(`Berita dengan slug "${currentSlug}" tidak ditemukan.`);
  }
};

onMounted(async () => {
    await fetchDetail(slug.value);
});
</script>

<style scoped>
/* Tambahkan style jika perlu */
</style>
