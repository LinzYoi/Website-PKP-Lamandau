<template>
  <v-row>    
    <v-col cols="12" md="3">
      <v-navigation-drawer
        v-model="drawer"
        :permanent="$vuetify.display.mdAndUp"
        :temporary="!$vuetify.display.mdAndUp"
        dark
        class="bg-grey-darken-3"
        clipped  
        width="330"      
        location="left"
      >        
        <div class="d-flex align-center justify-center pt-4 px-14">
          <v-img
            style="margin-left: -60px;"
            src="https://marketplace.canva.com/EAGVz4R0MRo/1/0/1600w/canva-biru-oranye-modern-bimbingan-belajar-logo-SpO4wb3Y_PE.jpg"
            width="80"
            height="80"            
          ></v-img>
          <div
            class="text-body-2 text-white font-weight-bold"
          >
            Bidang PKP Dinas PUPR
            <br />
            PERKIMTAN Kabupaten
            <br />
            Lamandau
          </div>
        </div>        

        <v-list v-if="$vuetify.display.smAndDown" class="mt-5">
          <v-list-item
            class="ps-4"
            prepend-avatar="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS22Rp5GdcJ_hJld-mdizd8Gg0O7SycPtiG5g&s"
          >
            <span class="font-weight-medium">
              <span class="text-white">ADMIN</span>
            </span>
          </v-list-item>
        </v-list>

        <v-divider class="mt-4 mb-4" />

        <v-list nav>
          <v-list-item
            prepend-icon="mdi-home"
            to="/pkp-lamandau/home"
            title="Dasbor"
          />

          <!-- Grup Navigasi dengan Sub-item -->
          <v-list-group v-model="drawerGroup">
            <template #activator="{ props }">
              <v-list-item
                v-bind="props"
                prepend-icon="mdi-menu"
                title="Dasbor Utama"
              />
            </template>

            <!-- Sub-navigasi -->
            <v-list-item
              to="/pkp-lamandau/pengelolaan-beranda"
              title="Pengelolaan Beranda"
            />
            <v-list-item
              to="/pkp-lamandau/data-pegawai"
              title="Pengelolaan Data Pegawai"
            />
            <v-list-item
              to="/pkp-lamandau/struktur-organisasi"
              title="Pengelolaan Struktur Organisasi"
            />
            <v-list-item
              to="/pkp-lamandau/pengelolaan-layanan"
              title="Pengelolaan Layanan"
            />
            <v-list-item
              to="/pkp-lamandau/pengelolaan-produk-hukum"
              title="Pengelolaan Produk Hukum"
            />
            <v-list-item
              to="/pkp-lamandau/pengelolaan-berita"
              title="Pengelolaan Berita"
            />
            <v-list-item
              to="/pkp-lamandau/pengelolaan-galeri"
              title="Pengelolaan Galeri"
            />
            <v-list-item
              to="/pkp-lamandau/pengelolaan-aspirasi"
              title="Pengelolaan Aspirasi"
            />
          </v-list-group>
        </v-list>

        <!-- tombol logout -->
        <v-list class="mt-0 pt-0" v-if="$vuetify.display.smAndDown">
          <v-list-item
            class="ps-4"
            prepend-icon="mdi-logout"
            title="Keluar"
            @click="logout()"
          />
          <!-- <v-list-item
            class="ps-4"
            prepend-icon="mdi-account"
            title="Profil"
            to="/pkp-lamandau/profil"
          /> -->
        </v-list>
      </v-navigation-drawer>
    </v-col>

    <v-col cols="12" md="9">
      <v-app-bar color="grey-lighten-4">
        <v-app-bar-nav-icon v-if="$vuetify.display.smAndDown" variant="text" @click.stop="drawer = !drawer" />

        <v-toolbar-title>{{ currentRouteTitle }}</v-toolbar-title>

        <v-spacer v-if="$vuetify.display.mdAndUp"></v-spacer>
        
        <v-divider
          v-if="$vuetify.display.mdAndUp"
          vertical
          color="black"
          class="border-opacity-50 me-4"
          style="height: 100%"
        ></v-divider>

        <div class="d-flex align-center me-2" v-if="$vuetify.display.mdAndUp">
          <v-avatar>
            <v-img
              src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS22Rp5GdcJ_hJld-mdizd8Gg0O7SycPtiG5g&s"
              width="40"
              height="40"
            ></v-img>
          </v-avatar>

          <v-menu offset-y>
            <template v-slot:activator="{ props }">
              <v-btn variant="text" v-bind="props" :ripple="false">                               
                <span class="mr-1 font-weight-bold text-none">ADMIN</span>
                <v-icon style="font-size: medium">mdi-chevron-down</v-icon>
              </v-btn>
            </template>            
            <v-card class="mt-4" rounded="xl" width="200">
              <v-list class="py-0 px-2 bg-grey-lighten-4">
                <v-list-item
                  class="px-2"
                  prepend-icon="mdi-account"
                  title="Profil"
                />
                <v-list-item
                  class="px-2"
                  prepend-icon="mdi-logout"
                  title="Keluar"
                />
              </v-list>
            </v-card>
          </v-menu>
        </div>
      </v-app-bar>

      <v-main class="pa-0 ms-6">
        <router-view></router-view>
      </v-main>
    </v-col>
  </v-row>
</template>

<script setup>
import { useUserStore } from "@/stores/user";
import { ref, computed } from "vue";
import { useRoute } from "vue-router";

// Variabel untuk kontrol drawer group
const drawer = ref(true); // default true untuk desktop
const drawerGroup = ref(false); // kontrol untuk open/close grup menu

// Mendapatkan rute aktif
const route = useRoute();

// Judul dinamis berdasarkan rute
const currentRouteTitle = computed(() => {
  switch (route.path) {
    case "/pkp-lamandau/home":
      return "Dasbor";
    case "/pkp-lamandau/pengelolaan-beranda":
      return "Pengelolaan Beranda";
    case "/pkp-lamandau/data-pegawai":
      return "Pengelolaan Data Pegawai";
    case "/pkp-lamandau/struktur-organisasi":
      return "Pengelolaan Struktur Organisasi";
    case "/pkp-lamandau/pengelolaan-layanan":
      return "Pengelolaan Layanan";
    case "/pkp-lamandau/pengelolaan-produk-hukum":
      return "Pengelolaan Produk Hukum";
    case "/pkp-lamandau/pengelolaan-berita":
      return "Pengelolaan Berita";
    case "/pkp-lamandau/pengelolaan-galeri":
      return "Pengelolaan Galeri";
    case "/pkp-lamandau/pengelolaan-aspirasi":
      return "Pengelolaan Aspirasi";
    default:
      return "Pengelolaan Beranda";
  }
});
</script>
