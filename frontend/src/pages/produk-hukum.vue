<template>
  <v-responsive>
    <v-app>
      <NavigationBeranda />

      <v-main
        :style="
          $vuetify.display.lgAndUp ? 'margin-top: 280px' : 'margin-top: 140px'
        "
      >
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <p class="text-h5 text-md-h3 font-weight-bold text-center">
                Produk Hukum
              </p>

              <div class="mt-10">
                <p class="text-md-body-1 text-justify">
                  Halaman ini menyediakan kumpulan produk hukum yang berkaitan
                  dengan kebijakan, pedoman teknis, dan ketentuan peraturan di
                  bidang Perumahan dan Kawasan Permukiman. Produk hukum ini
                  menjadi dasar dalam pelaksanaan kegiatan serta pelayanan
                  publik di lingkungan Dinas PUPR PERKIMTAN Kabupaten Lamandau.
                  Seluruh dokumen dapat diunduh sebagai referensi atau kebutuhan
                  administratif oleh masyarakat, pelaku usaha, dan instansi
                  terkait.
                </p>
              </div>

              <div class="mt-16">
                <v-data-table
                  :headers="headers"
                  :items="produkHukums"
                  :search="search"
                  :loading="loadingTable"
                  loading-text="Loading..."
                >
                  <template v-slot:item.no="{ index }">
                    {{ index + 1 }}
                  </template>
                  <template v-slot:item.file_dokumen_produk_hukum="{ item }">
                    <a
                      :href="`${baseUrl}/storage/${item.file_dokumen_produk_hukum}`"
                      target="_blank"
                      class="text-decoration-none"
                    >
                      <v-icon
                        v-if="
                          item.file_dokumen_produk_hukum.split('.').pop() ===
                          'zip'
                        "
                        size="30"
                        color="yellow-darken-3"
                        >mdi-folder-zip</v-icon
                      >
                      <v-icon
                        v-else-if="
                          item.file_dokumen_produk_hukum.split('.').pop() ===
                          'pdf'
                        "
                        size="30"
                        color="red-darken-2"
                        >mdi-file-pdf-box</v-icon
                      >
                      <v-icon
                        v-else-if="
                          item.file_dokumen_produk_hukum.split('.').pop() ===
                          'doc'
                        "
                        size="30"
                        color="blue-darken-3"
                        >mdi-file-word</v-icon
                      >
                      <v-icon
                        v-else-if="
                          item.file_dokumen_produk_hukum.split('.').pop() ===
                          'docx'
                        "
                        size="30"
                        color="blue-darken-3"
                        >mdi-file-word</v-icon
                      >
                      <br />
                      <span
                        class="text-caption font-weight-regular text-decoration-underline text-grey-darken-3"
                      >
                        Unduh disini
                      </span>
                    </a>
                  </template>
                </v-data-table>
              </div>
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
import { computed, onMounted, ref } from "vue";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;
const baseUrl = config.baseUrl;

import { useProdukHukumStore } from "@/stores/produkHukum";

const produkHukumStore = useProdukHukumStore();
const produkHukums = computed(() => produkHukumStore.produkHukums);

const headers = ref([
  { title: "No", value: "no" },
  { title: "Bentuk", value: "bentuk_produk_hukum", sortable: true },
  { title: "Judul", value: "judul_produk_hukum", sortable: true },
  { title: "Tahun", value: "tahun_produk_hukum", sortable: true },
  { title: "Dokumen", value: "file_dokumen_produk_hukum" },
]);

const search = ref("");

// const berandas = computed(() => berandaStore.berandas);

// tanggal hari ini

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

onMounted(() => {
  produkHukumStore.getAllProdukHukums();
});
</script>

<style scoped></style>
