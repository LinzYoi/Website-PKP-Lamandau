<template>
  <v-responsive>
    <v-app>
      <NavigationBeranda />

      <v-main style="margin-top: 280px">
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <p class="text-h5 text-md-h3 font-weight-bold text-center mb-10">
                Tentang PKP
              </p>
              <v-row align="center" justify="start">
                <v-col cols="12">
                  <p class="text-body-1 text-justify">
                    Bidang Perumahan dan Kawasan Permukiman adalah salah satu
                    bidang yang bertanggung jawab untuk mengelola dan
                    mengembangkan perumahan dan kawasan permukiman yang layak,
                    sehat, dan berkelanjutan. Bidang ini memiliki tugas untuk
                    meningkatkan kualitas perumahan dan lingkungan permukiman,
                    serta menyediakan fasilitas dan infrastruktur yang memadai
                    untuk mendukung kehidupan masyarakat yang lebih baik. Dengan
                    fokus pada pengembangan perumahan yang terjangkau dan
                    lingkungan permukiman yang nyaman, bidang ini berupaya untuk
                    menciptakan hunian yang ideal bagi masyarakat dan
                    meningkatkan kualitas hidup mereka
                  </p>
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

onMounted(() => {});
</script>

<style scoped></style>
