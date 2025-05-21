<template>
  <v-container fluid>
    <v-row align="center" justify="center">
      <v-col cols="12" sm="10">
        <div class="text-h4 text-grey-darken-4 text-center raleway-font font-weight-bold">
          Pendaftaran Warga
        </div>

        <p class="text-body-1 text-center">
          Silahkan isi data anda.
        </p>        

        <div class="mt-0">
          <v-form v-model="isFormValid" @submit.prevent>
            <v-row>
              <v-col cols="12" class="pb-0 mt-1">
                <div class="mt-7">
                  <p class="text-start text-h5 font-weight-medium text-grey-darken-3">
                    Data Diri
                  </p>
                </div>
              </v-col>
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.nama_warga"
                  :rules="rules.nama_warga"                  
                  rounded="lg"
                  variant="outlined"
                  label="Nama Warga"
                  placeholder="Nama Warga"                  
                ></v-text-field>
              </v-col>
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.no_telp_warga"
                  :rules="rules.no_telp_warga"
                  type="number"       
                  rounded="lg"
                  variant="outlined"
                  label="No Telepon Warga"
                  placeholder="No Telepon Warga"                  
                ></v-text-field>
              </v-col>
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.nik"
                  :rules="rules.nik"
                  type="number"                  
                  rounded="lg"
                  variant="outlined"
                  label="NIK"
                  placeholder="NIK"                  
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="5" class="pb-0">
                <v-text-field
                  v-model="form.tempat_lahir"
                  :rules="rules.tempat_lahir"
                  rounded="lg"
                  variant="outlined"
                  label="Tempat Lahir"
                  placeholder="Tempat Lahir"                  
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="7" class="pb-0">
                <v-date-input
                  v-model="form.tanggal_lahir"
                  :rules="rules.tanggal_lahir"                  
                  rounded="lg"
                  variant="outlined"
                  label="Tanggal Lahir"
                  placeholder="Tanggal Lahir"
                  prepend-icon=""
                  append-inner-icon="mdi-calendar"
                ></v-date-input>
              </v-col>
              <v-col cols="12" class="pb-0">
                <v-textarea
                  v-model="form.alamat_ktp"
                  :rules="rules.alamat_ktp"
                  rounded="lg"
                  variant="outlined"
                  label="Alamat KTP"
                  placeholder="Alamat KTP"                  
                ></v-textarea>
              </v-col>
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.universitas"
                  :rules="rules.universitas"
                  rounded="lg"
                  variant="outlined"
                  label="Universitas"
                  placeholder="Universitas"                  
                ></v-text-field>
              </v-col>
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.angkatan"
                  :rules="rules.angkatan"
                  type="number"
                  rounded="lg"
                  variant="outlined"
                  label="Angkatan"
                  placeholder="Angkatan"                  
                ></v-text-field>
              </v-col>
              <v-col cols="6" class="pb-0">
                <v-file-input
                  v-model="form.ktp_file"
                  :rules="rules.ktp_file"
                  rounded="lg"
                  variant="outlined"
                  label="File KTP"
                  placeholder="File KTP"           
                  prepend-icon=""
                  append-inner-icon="mdi-file-document"       
                ></v-file-input>
              </v-col>
              <v-col cols="6" class="pb-0">
                <v-file-input
                  v-model="form.ktm_file"
                  :rules="rules.ktm_file"
                  rounded="lg"
                  variant="outlined"
                  label="File KTM"
                  placeholder="File KTM"                  
                  prepend-icon=""
                  append-inner-icon="mdi-file-document"
                ></v-file-input>
              </v-col>              
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.email_warga"
                  :rules="rules.email_warga"
                  rounded="lg"
                  variant="outlined"
                  label="Email Warga"
                  type="email"
                  placeholder="email@gmail.com"
                ></v-text-field>
              </v-col>
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.password_warga"
                  :rules="rules.password_warga"
                  rounded="lg"
                  variant="outlined"
                  label="Password Warga"
                  :type="showPassword ? 'text' : 'password'"
                  :append-inner-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                  @click:append-inner="togglePasswordVisibility"
                ></v-text-field>
              </v-col>

              <v-col cols="12" class="pb-0 mt-1">
                <div class="mt-7">
                  <p class="text-start text-h5 font-weight-medium text-grey-darken-3">
                    Data Orang Tua
                  </p>
                </div>
              </v-col>

              <div class="mt-6 mx-3" style="width: max-content;">
                <v-tabs
                  v-model="tab"
                  bg-color="primary"                  
                >
                  <v-tab value="one">Belum ada keluarga</v-tab>
                  <v-tab value="two">Sudah ada orang tua</v-tab>
                </v-tabs>

                <v-card-text class="px-0">
                  <v-tabs-window v-model="tab">
                    <v-tabs-window-item value="one">
                      <!-- form orang tua -->
                      <v-col cols="12" class="pb-0 mt-4">
                        <v-text-field
                          v-model="form.nama_ayah"
                          :rules="rules.nama_ayah"
                          rounded="lg"
                          variant="outlined"
                          label="Nama Ayah"
                          placeholder="Nama Ayah"                  
                        ></v-text-field>
                      </v-col>
                      <v-col cols="12" class="pb-0">
                        <v-text-field
                          v-model="form.nama_ibu"
                          :rules="rules.nama_ibu"
                          rounded="lg"
                          variant="outlined"
                          label="Nama Ibu"
                          placeholder="Nama Ibu"                  
                        ></v-text-field>
                      </v-col>
                      <v-col cols="12" class="pb-0">
                        <v-text-field
                          v-model="form.alamat"
                          :rules="rules.alamat"
                          rounded="lg"
                          variant="outlined"
                          label="Alamat"
                          placeholder="Alamat"                  
                        ></v-text-field>
                      </v-col>
                      <v-col cols="12" class="pb-0">
                        <v-text-field
                          v-model="form.no_telp_ortu"
                          :rules="rules.no_telp_ortu"
                          type="number"                  
                          rounded="lg"
                          variant="outlined"
                          label="No Telepon Orang Tua"
                          placeholder="No Telepon Orang Tua"                  
                        ></v-text-field>
                      </v-col>
                      <v-col cols="12" class="pb-0">
                        <v-text-field
                          v-model="form.email_ortu"
                          :rules="rules.email_ortu"
                          rounded="lg"
                          variant="outlined"
                          label="Email Orang Tua"
                          type="email"
                          placeholder="email@gmail.com"
                        ></v-text-field>
                      </v-col>
                      <v-col cols="12" class="pb-0">
                        <v-text-field
                          v-model="form.password_ortu"
                          :rules="rules.password_ortu"
                          rounded="lg"
                          variant="outlined"
                          label="Password Orang Tua"
                          :type="showPassword ? 'text' : 'password'"
                          :append-inner-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                          @click:append-inner="togglePasswordVisibility"
                        ></v-text-field>
                      </v-col>
                    </v-tabs-window-item>

                    <v-tabs-window-item value="two">
                      <v-text-field
                        v-model="form.search_ortu"                        
                        rounded="lg"
                        variant="outlined"
                        prepend-inner-icon="mdi-magnify"
                        label="Nama Orang Tua"
                        placeholder="Nama Orang Tua"                      
                      ></v-text-field>
                    </v-tabs-window-item>
                  </v-tabs-window>
                </v-card-text>
              </div>              
              <v-col cols="12">
                <v-btn                  
                  type="submit"
                  :disabled="!isFormValid"                  
                  class="py-6"
                  color="green"
                  text="Daftar"
                  rounded="lg"
                  block
                  @click="pendaftaranWarga()"
                ></v-btn>
                <div
                  class="font-weight-medium mt-2 d-flex justify-center align-center"
                >
                  Sudah punya akun?&nbsp;
                  <span class="text-blue-darken-3">
                    <router-link to="/login">Masuk</router-link>
                  </span>
                </div>
              </v-col>              
            </v-row>
          </v-form>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import axios from "axios";
import router from "@/router";
import { ref, watch, onBeforeUnmount } from "vue";
import { useToast } from "vue-toastification";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;


const isFormValid = ref(false);
const showPassword = ref(false);
const loading = ref(false);


const tab = ref("one");
// const isTabOne = ref(true);


const form = ref({
  nama_warga: "",
  no_telp_warga: "",  
  nik: "",
  tempat_lahir: "",
  tanggal_lahir: "",
  alamat_ktp: "",
  universitas: "",
  angkatan: "",
  ktp_file: null,
  ktm_file: null,
  email_warga: "",
  password_warga: "",
  
  nama_ayah: "",
  nama_ibu: "",
  alamat: "",
  nama_ortu: "",
  no_telp_ortu: "",
  email_ortu: "",
  password_ortu: "",
});

const rules = {
  nama_warga: [
    (v) => !!v || "Nama harus diisi",
  ],
  no_telp_warga: [
    (v) => !!v || "Nomor Telepon harus diisi",
    (v) => v?.length >= 10 || "Nomor Telepon harus minimal 10 digit",    
  ],
  nik: [
    (v) => !!v || "NIK harus diisi",
    (v) => v?.length >= 16 || "NIK harus minimal 16 digit",
  ],
  tempat_lahir: [
    (v) => !!v || "Tempat Lahir harus diisi",
  ],
  tanggal_lahir: [
    (v) => !!v || "Tanggal Lahir harus diisi",    
    (v) => new Date(v) < new Date() || "Tanggal Lahir tidak boleh hari ini atau besok",
  ],
  alamat_ktp: [
    (v) => !!v || "Alamat KTP harus diisi",
  ],
  universitas: [
    (v) => !!v || "Universitas harus diisi",
  ],
  angkatan: [
    (v) => !!v || "Angkatan harus diisi",
  ],
  ktp_file: [
    (v) => !!v || "File KTP harus diisi",
  ],
  ktm_file: [
    (v) => !!v || "File KTM harus diisi",
  ],
  email_warga: [
    (v) => !!v || "Email harus diisi",
    (v) => /.+@.+\..+/.test(v) || "Email tidak valid",
  ],
  password_warga: [
    (v) => !!v || "Password harus diisi",
    // (v) => v.length >= 8 || "Password harus minimal 8 karakter",
    // (v) => /[A-Z]/.test(v) || "Password harus mengandung huruf kapital",
    // (v) => /[a-z]/.test(v) || "Password harus mengandung huruf kecil",
    // (v) => /[0-9]/.test(v) || "Password harus mengandung angka",
  ],

  nama_ayah: [
    (v) => !!v || "Nama Ayah harus diisi",
  ],
  nama_ibu: [
    (v) => !!v || "Nama Ibu harus diisi",
  ],
  alamat: [
    (v) => !!v || "Alamat harus diisi",
  ],
  no_telp_ortu: [
    (v) => !!v || "Nomor Telepon harus diisi",
    (v) => v?.length >= 10 || "Nomor Telepon harus minimal 10 digit",
  ],
  email_ortu: [
    (v) => !!v || "Email harus diisi",
    (v) => /.+@.+\..+/.test(v) || "Email tidak valid",
  ],
  password_ortu: [
    (v) => !!v || "Password harus diisi",
    // (v) => v.length >= 8 || "Password harus minimal 8 karakter",
    // (v) => /[A-Z]/.test(v) || "Password harus mengandung huruf kapital",
    // (v) => /[a-z]/.test(v) || "Password harus mengandung huruf kecil",
    // (v) => /[0-9]/.test(v) || "Password harus mengandung angka",
  ],
};

const togglePasswordVisibility = () => {
  showPassword.value = !showPassword.value;
};

const pendaftaranWarga = () => {
  loading.value = true;
  form.value.nama_ortu = form.value.nama_ayah + " & " + form.value.nama_ibu;

  if (form.value.ktp_file == "") {
    useToast().error("File KTP harus diisi");    
    return;
  }

  if (form.value.ktp_file.size > 2 * 1024 * 1024) {
    useToast().error("File KTP tidak boleh lebih dari 2MB");
    return;
  }

  // Format tanggal sebelum append
  const isoDate = new Date(form.value.tanggal_lahir);
  const formattedDate = isoDate.toISOString().split('T')[0]; // hasil: 'YYYY-MM-DD'
  form.value.tanggal_lahir = formattedDate;


  const formData = new FormData();
  Object.entries(form.value).forEach(([key, value]) => {
    formData.append(key, value);
  });

  axios.post(apiBaseUrl + '/pendaftaran-warga', formData, {
    headers: {
      "Content-Type": "multipart/form-data",
    },
  })
    .then((response) => {
      useToast().success(response.data.message);
      router.push("/login");
    })
    .catch((error) => {
      useToast().error(error.response.data.message);
    })
    .finally(() => {
      loading.value = false;
    });
};
</script>
