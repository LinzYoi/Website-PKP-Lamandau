<template>
  <v-responsive>
    <v-app>
      <NavigationBeranda />

      <v-main style="margin-top: 280px">
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <p class="text-h5 text-md-h3 font-weight-bold text-center mb-10">
                Profil Pegawai
              </p>

              <!-- <v-img
                :src="
                  `${baseUrl}/storage/` +
                  strukturOrganisasiStore.strukturOrganisasis[0]
                    ?.file_gambar_struktur_organisasi
                "
                width="100%"
                height="auto"
                contain
              ></v-img> -->

              <v-row align="center" justify="start">
                <v-col
                  v-for="pegawais in pegawaiStore.pegawais"
                  :key="pegawais.id"
                  cols="12"
                  sm="6"
                  md="4"
                  :class="{
                    'px-2': $vuetify.display.smAndDown,
                    'px-16': $vuetify.display.mdAndUp,
                  }"
                >
                  <v-card
                    color="grey-lighten-3"
                    rounded="lg"
                    elevation="8"
                    min-height="470"
                    class="d-flex flex-column justify-space-between card-hover card-hover-color"
                    style="height: 100%"
                  >
                    <v-img
                      :src="`${baseUrl}/storage/${pegawais.file_pegawai}`"
                      height="300"
                      cover
                    ></v-img>

                    <div class="px-4 pt-2">
                      <p class="text-h6 font-weight-bold">
                        {{ pegawais.nama }}
                      </p>
                      <p class="text-md-body-1">
                        {{ pegawais.jabatan }}
                      </p>
                    </div>

                    <div class="flex-grow-1"></div>
                  </v-card>
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

import { computed, onMounted, ref } from "vue";

import config from "../../../config";
const apiBaseUrl = config.apiBaseUrl;
const baseUrl = config.baseUrl;

import { usePegawaiStore } from "@/stores/pegawai";
const pegawaiStore = usePegawaiStore();

const search = ref("");

// const berandas = computed(() => berandaStore.berandas);

// tanggal hari ini

const formattedDate = (date) => {
  const options = {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  };
  return new Date(date).toLocaleDateString("id-ID", options);
};

const profilItems = ref([
  { title: "Tentang PKP", to: "/profil/tentang-pkp" },
  { title: "Tugas Pokok dan Fungsi", to: "/profil/tugas-pokok-dan-fungsi" },
  { title: "Visi & Misi", to: "/profil/visi-dan-misi" },
  { title: "Struktur Organisasi", to: "/profil/struktur-organisasi" },
  { title: "Profil Pegawai", to: "/profil/profil-pegawai" },
]);

onMounted(async () => {
  await pegawaiStore.getAllpegawais();
});
</script>

<style scoped>
/* .card-hover-color:hover {
  background-color: #ffcc00 !important;
} */
</style>
