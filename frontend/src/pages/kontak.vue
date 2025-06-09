<template>
  <v-responsive>
    <v-app>
      <NavigationBeranda />

      <v-main style="margin-top: 280px">
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <p class="text-h5 text-md-h3 font-weight-bold text-center mb-10">
                Kontak
              </p>

              <v-row align="center" justify="start">
                <v-col cols="12">
                  <p class="text-h6 font-weight-bold">Hubungi Kami Melalui</p>
                  <v-row align="center" justify="start">
                    <v-col cols="2" class="pb-1 pt-5">
                      <p class="text-body-1 font-weight-regular">Telp</p>
                    </v-col>
                    <v-col cols="10" class="pb-1 pt-5">
                      <p class="text-body-1 font-weight-regular">
                        : (0532) 2071023 / 0532-2071024
                      </p>
                    </v-col>
                    <v-col cols="2" class="py-1">
                      <p class="text-body-1 font-weight-regular">Fax</p>
                    </v-col>
                    <v-col cols="10" class="py-1">
                      <p class="text-body-1 font-weight-regular">
                        : 0532-2071031
                      </p>
                    </v-col>
                    <v-col cols="2" class="py-1">
                      <p class="text-body-1 font-weight-regular">E-mail</p>
                    </v-col>
                    <v-col cols="10" class="py-1">
                      <p class="text-body-1 font-weight-regular">
                        : dpu.kab.lamandau@gmail.com
                      </p>
                    </v-col>
                  </v-row>
                </v-col>
              </v-row>

              <v-row align="center" justify="start" class="mt-16">
                <v-col cols="12">
                  <p class="text-h6 font-weight-bold">Lokasi</p>
                  <v-row align="center" justify="start">
                    <v-col cols="12" class="pb-1 pt-5">
                      <p class="text-body-1 font-weight-regular">
                        RC7M+P9V, Komplek Perkantoran PEMDA Bukit Hibul, Prov.,
                        Nanga Bulik, Kec. Bulik, Kabupaten Lamandau, Kalimantan
                        Tengah 74161
                      </p>
                    </v-col>
                    <v-col cols="12" class="pb-1">                      
                      <iframe
                        src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d7973.843781225784!2d111.4265182!3d-2.1833273!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e0618fc0a449a51%3A0x97ac80dc1c328226!2sDinas%20Pekerjaan%20Umum%20Kab.%20Lamandau!5e0!3m2!1sen!2sid!4v1749481499746!5m2!1sen!2sid"
                        width="100%"
                        height="450"
                        style="border: 0"
                        allowfullscreen=""
                        loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade"
                      ></iframe>
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
              Bulik, Kec. Bulik, Kabupaten Lamandau, Kalimantan Tengah 74161
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
