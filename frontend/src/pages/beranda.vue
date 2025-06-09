<template>
  <v-responsive>
    <v-app>      
      <NavigationBeranda />
      <v-main
        :style="$vuetify.display.lgAndUp ? 'margin-top: 280px' : 'margin-top: 180px'"
      >
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <!-- <pre>{{ berandaStore.berandas }}</pre> -->
              <video
                :src="`${baseUrl}/storage/` + berandaStore.berandas[0]?.file_beranda"
                autoplay
                loop
                muted
                width="100%"
                height="auto"
              ></video>
            </v-col>

            <v-col cols="10" class="text-center card-hover" style="margin-top: 120px;">
              <p class="text-h5 text-md-h4 font-weight-bold mb-4">{{ berandaStore.berandas[1]?.judul_beranda }}</p>

              <div class="d-flex align-center justify-center">
                <v-img
                  v-if="berandaStore.berandas[2]?.file_beranda"
                  :src="`${baseUrl}/storage/` + berandaStore.berandas[1]?.file_beranda"
                  width="auto"
                  height="550"
                  contain
                ></v-img>
              </div>
            </v-col>

            <v-col cols="10" style="margin-top: 120px;">
              <v-row align="center">
                <v-col cols="5" class="card-hover">
                  <v-img
                    v-if="berandaStore.berandas[2]?.file_beranda"
                    :src="`${baseUrl}/storage/` + berandaStore.berandas[2]?.file_beranda"
                    cover                  
                  ></v-img>                  
                </v-col>
                <v-col cols="7">
                  <p class="text-h6 text-md-h4 font-weight-bold mb-4">{{ berandaStore.berandas[2]?.judul_beranda }}</p>
                  <p class="text-md-body-1 text-justify">{{ berandaStore.berandas[2]?.deskripsi_beranda }}</p>
                </v-col>
              </v-row>
            </v-col>

            <v-col cols="10" style="margin-top: 120px;">
              <v-row align="center">
                <v-col cols="7" class="">
                  <p class="text-h6 text-md-h4 font-weight-bold mb-4">{{ berandaStore.berandas[3]?.judul_beranda }}</p>
                  <p class="text-md-body-1 text-justify mb-4">{{ berandaStore.berandas[3]?.deskripsi_beranda }}</p>
                  <p class="text-h6 text-md-h5 font-weight-bold">{{ berandaStore.berandas[3]?.nama }}</p>
                </v-col>
                <v-col cols="5" class="card-hover">
                  <v-img
                    v-if="berandaStore.berandas[3]?.file_beranda"
                    :src="`${baseUrl}/storage/` + berandaStore.berandas[3]?.file_beranda"                                        
                    cover
                  ></v-img>
                </v-col>
              </v-row>
            </v-col>

            <v-col cols="10" style="margin-top: 120px;">
              <p class="text-h5 text-md-h3 font-weight-bold text-center mb-16">Berita</p>
              <v-row align="center">
                <v-col
                  v-for="beritas in beritaStore.beritas"
                  :key="beritas.id"
                  cols="12"
                  sm="6"
                  md="4"
                >
                  <v-card
                    color="grey-lighten-3"
                    rounded="lg"
                    elevation="8"
                    min-height="470"
                    class="d-flex flex-column justify-space-between"
                    style="height: 100%;"
                  >
                    <v-img
                      :src="`${baseUrl}/storage/${beritas.file_gambar_berita}`"
                      height="300"
                      cover
                    ></v-img>

                    <div class="px-4 pt-2">
                      <p class="text-h6 font-weight-bold">
                        {{ beritas.judul_berita }}
                      </p>
                      <p class="text-md-body-1">
                        {{ beritas.deskripsi_berita }}
                      </p>
                    </div>

                    <div class="flex-grow-1"></div> <!-- Spacer agar tombol selalu ke bawah -->

                    <div class="px-4 pb-4 mt-8 d-flex justify-end">
                      <v-btn                        
                        variant="text"
                        rounded="lg"
                        class="text-md-body-1 font-weight-bold bg-white btn-hover"
                        @click="goToDetail(beritas)"
                      >
                        Selengkapnya
                      </v-btn>
                    </div>
                  </v-card>
                </v-col>
              </v-row>
            </v-col>

            <v-col cols="10" style="margin-top: 120px;">
              <p class="text-h5 text-md-h3 font-weight-bold text-center mb-16">Galeri</p>
              <v-row align="center">
                <v-col
                  v-for="galeris in galeriStore.galeris"
                  :key="galeris.id"
                  cols="12"
                  sm="6"
                  md="4"
                >
                  <v-card                                         
                    rounded="xl"
                    elevation="0"
                    height="250"
                    class="d-flex flex-column justify-space-between card-hover"                    
                  >
                    <v-img
                      :src="`${baseUrl}/storage/${galeris.file_gambar_media}`"
                      height="auto"
                      cover
                    ></v-img>
                  </v-card>
                </v-col>
              </v-row>
            </v-col>
          </v-row>
        </v-container>
      </v-main>

      <v-footer class="text-center d-flex flex-column py-16 px-16" color="#FFD95F" style="margin-top: 110px;">
        <v-row align="center" justify="center">
          <v-col cols="5" class="d-flex align-center pe-12">
            <!-- gambar -->
            <v-img
              src="/logo_pkp_lamandau.png"
              width="50"
              height="auto"              
            ></v-img>
            <p class="ms-4 text-body-1 text-justify font-weight-bold">Bidang Perumahan dan Kawasan Permukiman (PKP) Dinas PUPR PERKIMTAN Kabupaten Lamandau</p>
          </v-col>
          <v-col cols="5" class="ps-12">            
            <p class="text-body-1 font-weight-medium text-justify">
              RC7M+P9V, Komplek Perkantoran PEMDA Bukit Hibul, Prov., Nanga Bulik, Kec. Bulik, Kabupaten Lamandau, Kalimantan Tengah 74161
              Telp : 0281 122143147931
            </p>
          </v-col>
        </v-row>

        <div class="mt-14">
          <span class="text-caption">Copyright © Bidang Perumahan dan Kawasan Permukiman (PKP) Dinas PUPR PERKIMTAN Kabupaten Lamandau 2025</span>
        </div>
      </v-footer>
    </v-app>
  </v-responsive>
</template>

<script setup>
import NavigationBeranda from '@/components/NavigationBeranda.vue';
import { computed, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;
const baseUrl = config.baseUrl;

import { useBerandaStore } from '@/stores/beranda';
import { useBeritaStore } from '@/stores/berita';
import { useGaleriStore } from '@/stores/galeri';

const router = useRouter();
const berandaStore = useBerandaStore();
const beritaStore = useBeritaStore();
const galeriStore = useGaleriStore();

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

onMounted(() => {
  berandaStore.getAllBerandas();
  beritaStore.getAllBeritas();
  galeriStore.getAllGaleris();
});
</script>

<style scoped>

</style>