<template>
  <v-container
    fluid
    class="dashboard-bg"
    style="min-height: 100dvh; align-items: center; justify-content: center; display: flex;"
  >
    <v-row
      align="center"
      justify="center"
      class="pt-12"
    >
      <!-- Layanan -->
      <v-col
        cols="12"
        sm="6"
        md="4"
        class="d-flex justify-center mb-8"
      >
        <v-card
          class="dashboard-card pa-4"
        >
          <div class="text-h6 text-center font-weight-regular grey--text text--darken-1">
            Layanan
          </div>
          <div class="text-h5 text-center font-weight-medium">
            {{ layanans.length }}
          </div>
        </v-card>
      </v-col>

      <!-- Galeri -->
      <v-col
        cols="12"
        sm="6"
        md="4"
        class="d-flex justify-center mb-8"
      >
        <v-card class="dashboard-card pa-4">
          <div class="text-h6 text-center font-weight-regular grey--text text--darken-1">
            Galeri
          </div>
          <div class="text-h5 text-center font-weight-medium">
            {{ galeris.length }}
          </div>
        </v-card>
      </v-col>

      <!-- Produk Hukum -->
      <v-col
        cols="12"
        sm="6"
        md="4"
        class="d-flex justify-center mb-8"
      >
        <v-card class="dashboard-card pa-4">
          <div class="text-h6 text-center font-weight-regular grey--text text--darken-1">
            Produk Hukum
          </div>
          <div class="text-h5 text-center font-weight-medium">
            {{ produkHukums.length }}
          </div>
        </v-card>
      </v-col>

      <!-- Aspirasi -->
      <v-col
        cols="12"
        sm="6"
        md="4"
        class="d-flex justify-center mb-8"
      >
        <v-card class="dashboard-card pa-4">
          <div class="text-h6 text-center font-weight-regular grey--text text--darken-1">
            Aspirasi
          </div>
          <div class="text-h5 text-center font-weight-medium">
            {{ aspirasis.length }}
          </div>
        </v-card>
      </v-col>

      <!-- Berita -->
      <v-col
        cols="12"
        sm="6"
        md="4"
        class="d-flex justify-center mb-8"
      >
        <v-card class="dashboard-card pa-4">
          <div class="text-h6 text-center font-weight-regular grey--text text--darken-1">
            Berita
          </div>
          <div class="text-h5 text-center font-weight-medium">
            {{ beritas.length }}
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { onMounted, computed } from "vue";
import { useUserStore } from "@/stores/user";
import { useLayananStore } from "@/stores/layanan";
import { useGaleriStore } from "@/stores/galeri";
import { useProdukHukumStore } from "@/stores/produkHukum";
import { useAspirasiStore } from "@/stores/aspirasi";
import { useBeritaStore } from "@/stores/berita";

import config from "../../../config";
const baseUrl = config.baseUrl;

const userStore = useUserStore();
const layananStore = useLayananStore();
const galeriStore = useGaleriStore();
const produkHukumStore = useProdukHukumStore();
const aspirasiStore = useAspirasiStore();
const beritaStore = useBeritaStore();

const layanans = computed(() => layananStore.layanans);
const galeris = computed(() => galeriStore.galeris);
const produkHukums = computed(() => produkHukumStore.produkHukums);
const aspirasis = computed(() => aspirasiStore.aspirasis);
const beritas = computed(() => beritaStore.beritas);

onMounted(() => {
  layananStore.getAllLayanans();
  galeriStore.getAllGaleris();
  produkHukumStore.getAllProdukHukums();
  aspirasiStore.getAllAspirasis();
  beritaStore.getAllBeritas();
});
</script>

<style scoped>
.dashboard-bg {
  /* background-color: #ECEFF1; light grey */
  min-height: 100vh;         /* fill the screen */
}
.dashboard-card {
  width: 200px;
  border-radius: 16px;
  background: #efefef;
  /* box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); */
}
</style>