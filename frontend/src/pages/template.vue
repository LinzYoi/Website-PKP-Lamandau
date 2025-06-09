<template>
  <v-responsive>
    <v-app>
      <v-app-bar
        color="#FFD95F"
        :elevation="0"
        height="fit-content"
        class="py-8 px-16"
      >
        <template v-slot:prepend>
          <v-app-bar-nav-icon
            v-if="$vuetify.display.mdAndDown"
          ></v-app-bar-nav-icon>
          <v-img
            v-if="$vuetify.display.lgAndUp"
            src="/logo_pkp_lamandau.png"
            width="125"
            height="auto"
          ></v-img>

          <div class="ms-4">
            <v-row align="start">
              <v-col cols="9">
                <p class="text-h6 text-lg-h4 font-weight-bold">
                  Bidang Perumahan dan Kawasan Permukiman (PKP) Dinas PUPR
                  PERKIMTAN Kabupaten Lamandau
                </p>
              </v-col>
              <v-col cols="3" class="text-start pt-4">
                <p class="text-caption font-weight-bold text-md-body-1">
                  {{ formattedDate }}
                </p>
              </v-col>
            </v-row>

            <v-row
              align="center"
              justify="start"
              class="mt-6"
              v-if="$vuetify.display.lgAndUp"
            >
              <v-col cols="9" class="pb-0">
                <div class="d-flex align-center justify-start">
                  <div class="me-8">
                    <v-btn
                      :ripple="false"
                      color="black"
                      variant="text"
                      class="text-md-body-1 font-weight-bold px-0"
                      to="/"
                    >
                      Beranda
                    </v-btn>
                  </div>

                  <div class="me-2">
                    <v-btn
                      id="menu-activator"
                      :ripple="false"
                      color="black"
                      variant="text"
                      class="text-md-body-1 font-weight-bold px-0"
                      append-icon="mdi-chevron-down"
                    >
                      Profil
                    </v-btn>

                    <v-menu activator="#menu-activator">
                      <v-list>
                        <v-list-item
                          v-for="(item, index) in items"
                          :key="index"
                          :value="index"
                        >
                          <v-list-item-title>{{
                            item.title
                          }}</v-list-item-title>
                        </v-list-item>
                      </v-list>
                    </v-menu>
                  </div>

                  <div class="me-8">
                    <v-btn
                      :ripple="false"
                      color="black"
                      variant="text"
                      class="text-md-body-1 font-weight-bold px-0"
                    >
                      Layanan
                    </v-btn>
                  </div>

                  <div class="me-8">
                    <v-btn
                      :ripple="false"
                      color="black"
                      variant="text"
                      class="text-md-body-1 font-weight-bold px-0"
                      to="/produk-hukum"
                    >
                      Produk Hukum
                    </v-btn>
                  </div>

                  <div class="me-8">
                    <v-btn
                      :ripple="false"
                      color="black"
                      variant="text"
                      class="text-md-body-1 font-weight-bold px-0"
                    >
                      Berita
                    </v-btn>
                  </div>

                  <div class="me-8">
                    <v-btn
                      :ripple="false"
                      color="black"
                      variant="text"
                      class="text-md-body-1 font-weight-bold px-0"
                    >
                      Galeri
                    </v-btn>
                  </div>

                  <div class="me-8">
                    <v-btn
                      :ripple="false"
                      color="black"
                      variant="text"
                      class="text-md-body-1 font-weight-bold px-0"
                    >
                      Aspirasi
                    </v-btn>
                  </div>

                  <div class="me-8">
                    <v-btn
                      :ripple="false"
                      color="black"
                      variant="text"
                      class="text-md-body-1 font-weight-bold px-0"
                    >
                      Kontak
                    </v-btn>
                  </div>
                </div>
              </v-col>
              <v-col cols="3">
                <v-text-field
                  variant="outlined"
                  rounded="lg"
                  color="black"
                  class="text-md-body-1 font-weight-bold px-0 bg-grey-lighten-2 rounded-lg"
                  hide-details
                  placeholder="Pencarian"
                  density="compact"
                  append-inner-icon="mdi-magnify"
                ></v-text-field>
              </v-col>
            </v-row>
          </div>
        </template>

        <!-- <template v-slot:append>          
              
            </template> -->
      </v-app-bar>

      <v-main
        :style="
          $vuetify.display.lgAndUp ? 'margin-top: 280px' : 'margin-top: 140px'
        "
      >
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <p class="text-h5 text-md-h3 font-weight-bold text-center">
                Template
              </p>
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
import { computed, onMounted, ref } from "vue";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;
const baseUrl = config.baseUrl;

import { useBerandaStore } from "@/stores/beranda";
import { useBeritaStore } from "@/stores/berita";
import { useGaleriStore } from "@/stores/galeri";

const berandaStore = useBerandaStore();
const beritaStore = useBeritaStore();
const galeriStore = useGaleriStore();

const search = ref("");

// const berandas = computed(() => berandaStore.berandas);

// tanggal hari ini

const today = new Date();
const formattedDate = today.toLocaleDateString("id-ID", {
  weekday: "long",
  year: "numeric",
  month: "long",
  day: "numeric",
});

onMounted(() => {
  berandaStore.getAllBerandas();
  beritaStore.getAllBeritas();
  galeriStore.getAllGaleris();
});
</script>

<style scoped></style>
