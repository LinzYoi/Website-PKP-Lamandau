<template>
  <v-responsive>
    <v-app>
      <NavigationBeranda />

      <v-main style="margin-top: 280px">
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <p class="text-h5 text-md-h3 font-weight-bold text-center mb-10">
                Tugas Pokok dan Fungsi
              </p>

              <v-row align="center" justify="start">
                <v-col cols="12">
                  <p class="text-h6 font-weight-bold">Tugas Pokok</p>
                  <v-row align="center" justify="start">
                    <v-col cols="12" class="pb-1 pt-5">
                      <p class="text-body-1 font-weight-regular">Bidang Perumahan dan Kawasan Permukiman mempunyai tugas mengoordinasikan, menyelenggarakan dan melaksanakan penyelenggaraan Kawasan permukiman di Daerah.</p>
                    </v-col>                    
                  </v-row>
                </v-col>
              </v-row>

              <v-row align="center" justify="start" class="mt-16">
                <v-col cols="12">
                  <p class="text-h6 font-weight-bold">Fungsi</p>
                  <v-row align="center" justify="start">
                    <v-col cols="12" class="pb-1 pt-5">
                      <p class="text-body-1 font-weight-regular">
                        Untuk melaksanakan tugas sebagaimana dimaksud di atas, Bidang Perumahan dan Kawasan Permukiman menyelenggarakan fungsi:
                      </p>
                    </v-col>
                    <v-col cols="12" class="py-0">
                        <div class="ms-5">                            
                            <ol type="a" class="text-body-1 font-weight-regular">
                                <li>Penyusunan rencana, program dan kegiatan bidang perumahan dan kawasan permukiman;</li>                                
                                <li>Penyediaan rumah korban bencana kabupaten;</li>
                                <li>Rehabilitasi rumah korban bencana kabupaten;</li>
                                <li>Penyediaan rumah bagi masyarakat yang terkena relokasi program pemerintah daerah kabupaten;</li>
                                <li>Penerbitan perumahan izin pembangunan dan pengembangan perumahan;</li>
                                <li>Pelaksanaan perencanaan perumahan, pembangunan perumahan, pemanfaatan perumahan dan pengendalian perumahan;</li>
                                <li>Penyusunan dan menyempurnakan PHD tentang perizinan pembangunan dan pengembangan kawasan permukiman;</li>
                                <li>Penyusunan rencana kawasan permukiman;</li>
                                <li>Penataan dan peningkatan kualitas kawasan permukiman kumuh dengan luas di bawah 10 (sepuluh) ha;</li>
                                <li>Pengawasan dan pengendalian perumahan dan kawasan permukiman pada daerah kabupaten;</li>
                                <li>Pemberdayaan masyarakat dalam rangka mencegah perumahan dan kawasan permukiman kumuh;</li>
                                <li>Pelaksanaan sinkronisasi data pembangunan sarana, prasarana dan utilitas umum dengan rencana, rancangan dan perizinan;</li>
                                <li>Pelaksanaan inventarisasi data prasarana, sarana dan utilitas yang telah selesai dibangun oleh setiap orang;</li>
                                <li>Pelaksanaan perencanaan prasarana, sarana dan utilitas umum;</li>
                                <li>Pelaksanaan pengelolaan pertamanan kota;</li>
                                <li>Pelaksanaan pengelolaan pemakaman kota;</li>
                                <li>Sertifikasi bagi orang yang melaksanakan perancangan dan perencanaan rumah serta perencanaan Prasarana, Sarana dan Utilitas umum tingkat kemampuan kecil;</li>
                                <li>Pelaksanaan registrasi bagi badan hukum yang melaksanakan perancangan dan perencanaan rumah serta perencanaan Prasarana, Sarana dan Utilitas umum tingkat kemampuan kecil;</li>
                                <li>Pembinaan, pengendalian, pengendalian, pemantauan, evaluasi, dan pelaporan pelaksanaan tugas; dan</li>
                                <li>Pelaksanaan tugas lain yang diberikan atasan.</li>
                            </ol>                        
                        </div>
                    </v-col>
                  </v-row>
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

onMounted(() => {});
</script>

<style scoped></style>
