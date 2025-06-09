<template>
  <v-container fluid class="pa-0 fill-height">
    <v-row no-gutters class="fill-height">
      <!-- ========================================
           KOLOM KIRI (hanya tampil di md ke atas)
           ======================================== -->
      <v-col
        cols="12"
        md="6"
        class="d-none d-md-flex left-col"
      >
        <div class="left-placeholder">
          <!-- Ganti src dengan gambar/ilustrasi Anda -->
          <v-img
            
            alt="Placeholder"
            width="300"
            height="300"
            contain
          ></v-img>
        </div>
      </v-col>

      <!-- ========================================
           KOLOM KANAN (form login)
           ======================================== -->
      <v-col cols="12" md="6" class="d-flex align-center justify-center pa-8 right-col">
        <v-card flat class="login-card">
          <v-card-text>
            <!-- Logo + Nama Instansi -->
            <v-row align="center" class="mb-6">
              <v-col cols="2" class="text-center">
                <v-img
                  src="/logo_pkp_lamandau.png"
                  alt="Logo PKP"
                  width="100"
                  cover
                ></v-img>
              </v-col>
              <v-col cols="10" class="text-start ps-0">
                <div class="text-h6 font-weight-bold" style="line-height: normal !important;">
                  Bidang PKP Dinas PUPR PERKIMTAN <br />
                  Kabupaten Lamandau
                </div>
              </v-col>
            </v-row>

            <!-- Judul Masuk -->
            <div class="text-center text-h4 font-weight-bold mb-6">Masuk</div>

            <!-- FORM LOGIN -->
            <v-form v-model="isFormValid" @submit.prevent="login">
              <v-row>
                <v-col cols="12" class="pb-4">
                  <v-text-field
                    v-model="form.email"
                    :rules="rules.email"
                    label="E-mail"
                    placeholder="email@contoh.com"
                    rounded="lg"
                    variant="outlined"
                    prepend-inner-icon="mdi-email"
                    type="email"
                    hide-details="auto"
                  />
                </v-col>

                <v-col cols="12" class="pb-4">
                  <v-text-field
                    v-model="form.password"
                    :rules="rules.password"
                    label="Kata Sandi"
                    placeholder="Kata Sandi Anda"
                    :type="showPassword ? 'text' : 'password'"
                    :append-inner-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                    @click:append-inner="togglePasswordVisibility"
                    rounded="lg"
                    variant="outlined"
                    prepend-inner-icon="mdi-lock"
                    hide-details="auto"
                  />
                </v-col>

                <v-col cols="12" class="pt-2">
                  <v-btn
                    :disabled="!isFormValid"
                    :loading="loadingBtn"
                    color="#4CAF50"
                    class="white--text font-weight-bold py-4"
                    block
                    rounded="lg"
                    type="submit"
                  >
                    Masuk
                  </v-btn>
                </v-col>

                <v-col cols="12" class="text-center pt-4">
                  <router-link to="/lupa-password" class="text-decoration-none">
                    Lupa Kata Sandi?
                  </router-link>
                </v-col>

                <v-col cols="12" class="text-center pt-6">
                  Belum punya akun?
                  <router-link to="/sign-up" class="font-weight-bold text-blue">
                    Daftar di sini
                  </router-link>
                </v-col>
              </v-row>
            </v-form>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { ref } from "vue";
import axios from "axios";
import Cookies from "js-cookie";
import { useRouter } from "vue-router";
import { useToast } from "vue-toastification";
import { useUserStore } from "@/stores/user";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

const router = useRouter();
const toast = useToast();
const userStore = useUserStore();

const isFormValid = ref(false);
const showPassword = ref(false);
const loadingBtn = ref(false);

const form = ref({
  email: "",
  password: "",
});

const rules = {
  email: [
    (v) => !!v || "E-mail wajib diisi",
    (v) => /.+@.+\..+/.test(v) || "E-mail tidak valid",
  ],
  password: [
    (v) => !!v || "Kata Sandi wajib diisi",
    // Contoh rule tambahan:
    // (v) => v.length >= 8 || "Minimal 8 karakter",
    // (v) => /[A-Z]/.test(v) || "Minimal satu huruf besar",
    // (v) => /[0-9]/.test(v) || "Minimal satu angka",
  ],
};

const togglePasswordVisibility = () => {
  showPassword.value = !showPassword.value;
};

const login = async () => {
  loadingBtn.value = true;
  try {
    const response = await axios.post(`${apiBaseUrl}/login`, form.value);
    userStore.setUsers(response.data.data);
    Cookies.set("auth_token", response.data.data.auth_token, { expires: 1 });
    toast.success(response.data.message);
    router.push("/pkp-lamandau/home");
  } catch (error) {
    toast.error(error.response?.data?.message || "Login gagal");
  } finally {
    loadingBtn.value = false;
  }
};
</script>

<style scoped>
/* Elemen-elemen yang perlu full-height = 100vh */
.fill-height {
  height: 100vh !important;
}

/* Kolom kiri dengan background abu muda */
.left-col {
  background-color: #f5f5f5;
}

/* Placeholder di bagian kiri, agar kontennya di-center */
.left-placeholder {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Accordion Card (form) di kolom kanan */
.login-card {
  width: 100%;
  max-width: 700px;
  padding: 24px 16px;
}

/* Pada layar di bawah md (< 960px), tambahkan margin vertikal agar form tidak nempel atas/bawah */
@media (max-width: 960px) {
  .login-card {
    margin-top: 24px;
    margin-bottom: 24px;
  }
}
</style>
