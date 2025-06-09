<template>
  <v-responsive>
    <v-app>
      <NavigationBeranda />

      <v-main style="margin-top: 280px">
        <v-container fluid>
          <v-row align="center" justify="center">
            <v-col cols="10">
              <p class="text-h5 text-md-h3 font-weight-bold text-center mb-16">
                Aspirasi
              </p>

              <v-form v-model="isFormValid" @submit.prevent>
                <v-row align="center" justify="start" class="mb-8">
                  <v-col cols="12">
                    <p class="font-weight-bold text-h6 mb-2">Judul*</p>
                    <v-text-field
                      v-model="form.judul_aspirasi"
                      :rules="[(v) => !!v || 'Judul tidak boleh kosong']"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <p class="font-weight-bold text-h6 mb-2">Isi*</p>
                    <v-textarea
                      v-model="form.isi_aspirasi"
                      :rules="[(v) => !!v || 'Isi tidak boleh kosong']"
                      :clearable="true"
                      rows="4"
                      auto-grow
                    ></v-textarea>
                  </v-col>
                  <v-col cols="12" sm="5">
                    <p class="font-weight-bold text-h6 mb-2">Dokumentasi</p>
                    <v-file-input
                      v-model="form.file_gambar_aspirasi"                      
                      label="Pilih Berkas"
                      accept=".jpg, .jpeg, .png"
                      prepend-icon=""
                      append-inner-icon="mdi-paperclip"
                    ></v-file-input>
                  </v-col>
                  <v-col cols="12" class="mt-8 pb-0">
                    <p class="font-weight-black text-h6 mb-2">
                      Identitas Pengirim
                    </p>
                  </v-col>
                  <v-col cols="12" class="pt-0">
                    <p class="font-weight-bold text-h6 mb-2">Nama Anda*</p>
                    <v-text-field
                      v-model="form.nama_pembuat"
                      :rules="[(v) => !!v || 'Nama tidak boleh kosong']"
                      placeholder="Agus Budi Santoso"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <p class="font-weight-bold text-h6 mb-2">Nomor Telepon*</p>
                    <v-text-field
                      v-model="form.no_telp_pembuat"
                      :rules="[
                        (v) => !!v || 'Nomor telepon tidak boleh kosong',
                      ]"
                      type="number"
                      placeholder="08123456789"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <p class="font-weight-bold text-h6 mb-2">Alamat E-mail*</p>
                    <v-text-field
                      v-model="form.email_pembuat"
                      :rules="[
                        (v) => !!v || 'E-mail tidak boleh kosong',
                        (v) => /.+@.+\..+/.test(v) || 'E-mail tidak valid',
                      ]"                      
                      type="email"
                      placeholder="email@gmail.com"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <p class="font-weight-regular text-body-2 mb-2">
                      Kolom yang bertanda * wajib diisi.
                    </p>
                  </v-col>
                  <v-col cols="12" class="text-end">
                    <!-- captcha -->
                  </v-col>
                  <v-col cols="12" class="text-end">
                    <v-btn                      
                      color="grey-lighten-3"
                      variant="flat"
                      rounded="xl"
                      class="text-md-body-1 font-weight-bold btn-hover"
                      width="130"
                      @click="dialogAction = true"
                    >
                      Kirim
                    </v-btn>
                  </v-col>
                </v-row>
              </v-form>
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

  <v-dialog v-model="dialogAction" width="600" persistent>
    <v-card rounded="xl" class="pa-2 py-12">      
      <v-card-text class="text-center font-weight-bold text-h6 pt-0">
        <p>Anda yakin ingin mengirim aspirasi?</p>
      </v-card-text>
      <v-card-actions class="d-flex justify-center">        
        <v-btn size="x-large" class="text-none btn-hover" rounded="xl" width="120" color="grey-lighten-4" variant="flat" @click="dialogAction = false">Tidak</v-btn>
        <v-btn
          size="x-large"
          class="text-none ms-4 btn-hover"
          rounded="xl"
          width="120"
          color="grey-lighten-4"          
          variant="flat"          
          @click="tambahAspirasi(); dialogAction = false"    
        >
          Ya
        </v-btn>    
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup>
import NavigationBeranda from "@/components/NavigationBeranda.vue";
import { computed, onMounted, ref } from "vue";

import axios from "axios";
import { useToast } from "vue-toastification";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

const search = ref("");
const isFormValid = ref(false);
const dialogAction = ref(true);
// const berandas = computed(() => berandaStore.berandas);

// tanggal hari ini

const form = ref({});

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

const tambahAspirasi = () => {
  axios
    .post(apiBaseUrl + "/tambah-aspirasi", form.value, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      useToast().success(response.data.message);
      form.value = {};
      isFormValid.value = false;
    })
    .catch((error) => {
      console.log(error.response.data.message);
      useToast().error(error.response.data.message);
    });
};

onMounted(() => {});
</script>

<style scoped>

</style>
