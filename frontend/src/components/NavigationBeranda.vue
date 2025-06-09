<template>
  <v-app-bar
    color="#FFD95F"
    :elevation="0"
    height="fit-content"
    class="py-8 px-16"
  >
    <template v-slot:prepend>
      <v-img
        src="/logo_pkp_lamandau.png"
        :width="$vuetify.display.smAndDown ? 50 : 125"
        height="auto"
      ></v-img>

      <div class="ms-4">
        <v-row align="start">
          <v-col v-if="$vuetify.display.smAndUp" cols="9">
            <p class="text-h6 text-lg-h4 font-weight-bold">
              Bidang Perumahan dan Kawasan Permukiman (PKP) Dinas PUPR PERKIMTAN
              Kabupaten Lamandau
            </p>
          </v-col>
          <v-col
            v-if="$vuetify.display.lgAndUp"
            cols="3"
            class="text-start pt-4"
          >
            <p class="text-caption font-weight-bold text-md-body-1">
              {{ formattedDate(new Date()) }}
            </p>
          </v-col>
        </v-row>

        <v-row
          v-if="$vuetify.display.lgAndUp"
          align="center"
          justify="start"
          class="mt-6"
        >
          <v-col cols="9" class="pb-0">
            <div class="d-flex align-center justify-start">
              <div class="me-8">
                <v-btn
                  :ripple="false"
                  :active="false"
                  color="black"
                  variant="text"
                  class="text-md-body-1 font-weight-bold px-0"
                  to="/"
                >
                  Beranda
                </v-btn>
              </div>

              <div class="me-6">
                <v-btn
                  id="menu-activator"
                  :ripple="false"
                  :active="false"
                  color="black"
                  variant="text"
                  class="text-md-body-1 font-weight-bold px-0"
                  append-icon="mdi-chevron-down"
                >
                  Profil
                </v-btn>

                <v-menu activator="#menu-activator">
                  <v-card class="mx-auto" max-width="300">
                    <v-list :items="profilItems" class="pa-0" rounded="lg">
                      <v-list-item
                        v-for="(item, index) in profilItems"
                        :key="index"
                        :to="item.to"
                      >
                        <v-list-item-title class="text-md-body-1">
                          {{ item.title }}
                        </v-list-item-title>
                      </v-list-item>
                    </v-list>
                  </v-card>
                </v-menu>
              </div>

              <div class="me-8">
                <v-btn
                  :ripple="false"
                  :active="false"
                  color="black"
                  variant="text"
                  class="text-md-body-1 font-weight-bold px-0"
                  to="/layanan"
                >
                  Layanan
                </v-btn>
              </div>

              <div class="me-8">
                <v-btn
                  :ripple="false"
                  :active="false"
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
                  :active="false"
                  color="black"
                  variant="text"
                  class="text-md-body-1 font-weight-bold px-0"
                  to="/berita"
                >
                  Berita
                </v-btn>
              </div>

              <div class="me-8">
                <v-btn
                  :ripple="false"
                  :active="false"
                  color="black"
                  variant="text"
                  class="text-md-body-1 font-weight-bold px-0"
                  to="/galeri"
                >
                  Galeri
                </v-btn>
              </div>

              <div class="me-8">
                <v-btn
                  :ripple="false"
                  :active="false"
                  color="black"
                  variant="text"
                  class="text-md-body-1 font-weight-bold px-0"
                  to="/aspirasi"
                >
                  Aspirasi
                </v-btn>
              </div>

              <div class="me-8">
                <v-btn
                  :ripple="false"
                  :active="false"
                  color="black"
                  variant="text"
                  class="text-md-body-1 font-weight-bold px-0"
                  to="/kontak"
                >
                  Kontak
                </v-btn>
              </div>
            </div>
          </v-col>
          <v-col cols="3" v-if="$vuetify.display.lgAndUp">
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
    <template #append>
      <v-btn
        v-if="!$vuetify.display.lgAndUp"
        icon
        :ripple="false"
        @click="showMobileMenu = !showMobileMenu"
      >
        <v-icon :size="$vuetify.display.smAndDown ? 30 : 45">
          {{ showMobileMenu ? "mdi-close" : "mdi-menu" }}
        </v-icon>
      </v-btn>
    </template>
  </v-app-bar>
  <v-expand-transition>
    <v-list
      v-if="showMobileMenu"
      class="px-16"      
      :style="{
        backgroundColor: '#ffd95f',
        height: '100vh',
        paddingTop: $vuetify.display.smAndDown ? '160px' : '250px',
      }"      
    >
      <v-list-item title="Beranda" to="/"></v-list-item>

      <v-list-group>
        <template v-slot:activator="{ props }">
          <v-list-item v-bind="props" title="Profil"></v-list-item>
        </template>

        <v-list-group>
          <template v-slot:activator="{ props }">
            <v-list-item
              v-for="(item, index) in profilItems"
              :key="index"
              :to="item.to"
              append-icon=""
            >
              <v-list-item-title class="text-md-body-1">{{
                item.title
              }}</v-list-item-title>
            </v-list-item>
          </template>
        </v-list-group>
      </v-list-group>

      <v-list-item title="Layanan" to="/layanan"></v-list-item>
      <v-list-item title="Produk Hukum" to="/produk-hukum"></v-list-item>
      <v-list-item title="Berita" to="/berita"></v-list-item>
      <v-list-item title="Galeri" to="/galeri"></v-list-item>
      <v-list-item title="Aspirasi" to="/aspirasi"></v-list-item>
      <v-list-item title="Kontak" to="/kontak"></v-list-item>
    </v-list>
  </v-expand-transition>
</template>

<script setup>
import { computed, onMounted, ref } from "vue";

const search = ref("");
const showMobileMenu = ref(false);

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
</script>

<style scoped></style>
