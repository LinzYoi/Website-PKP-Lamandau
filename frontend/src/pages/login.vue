<template>
  <v-container fluid>
    <v-row align="center" justify="center">
      <v-col cols="12" sm="10">
        <div class="text-h4 text-sea_links_color text-center raleway-font font-weight-bold">
          Login
        </div>

        <p class="text-body-1 text-center">
          Silahkan login untuk melanjutkan.
        </p>
        <div class="mt-12">
          <v-form v-model="isFormValid" @submit.prevent>
            <v-row>
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.email"
                  :rules="rules.email"                  
                  rounded="lg"
                  variant="outlined"
                  label="Email"
                  type="email"
                  placeholder="email@gmail.com"
                ></v-text-field>
              </v-col>
              <v-col cols="12" class="pb-0">
                <v-text-field
                  v-model="form.password"
                  :rules="rules.password"
                  color="sea_links_color"
                  rounded="lg"
                  variant="outlined"
                  label="Password"
                  :type="showPassword ? 'text' : 'password'"
                  :append-inner-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                  @click:append-inner="togglePasswordVisibility"
                ></v-text-field>
              </v-col>
              <v-col cols="12">
                <v-btn                  
                  type="submit"
                  :disabled="!isFormValid"
                  :loading="loadingBtn"
                  class="py-6"
                  color="green"
                  text="Sign In"
                  rounded="lg"
                  block
                  @click="login()"
                ></v-btn>
                <div
                  class="font-weight-medium mt-2 d-flex justify-center align-center"
                >
                  Don't have account?&nbsp;
                  <span class="text-blue-darken-3">
                    <router-link to="/sign-up"> Sign Up </router-link>
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
import Cookies from "js-cookie";
import { useUserStore } from "@/stores/user";
import { useToast } from "vue-toastification";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

import router from "@/router";
import { ref } from "vue";

const isFormValid = ref(false);
const showPassword = ref(false);
const loadingBtn = ref(false);

const form = ref({
  email: "",
  password: "",
});

const rules = {
  email: [
    (v) => !!v || "E-mail is required",
    (v) => /.+@.+\..+/.test(v) || "E-mail must be valid",
  ],
  password: [
    (v) => !!v || "Password is required",
    // (v) => v.length >= 8 || "Password must be at least 8 characters",
    // (v) =>
    //   /[A-Z]/.test(v) || "Password must contain at least one uppercase letter",
    // (v) =>
    //   /[a-z]/.test(v) || "Password must contain at least one lowercase letter",
    // (v) => /[0-9]/.test(v) || "Password must contain at least one number",
  ],
};

const togglePasswordVisibility = () => {
  showPassword.value = !showPassword.value;
};

const login = () => {
  loadingBtn.value = true;

  axios.post(apiBaseUrl + '/login', form.value, {    
  })
    .then((response) => {            
      useUserStore().setUsers(response.data.data);      
      
      Cookies.set("auth_token", response.data.data.auth_token, { expires: 1 });
      
      useToast().success(response.data.message);

      router.push("/pkp-lamandau/home");
    })
    .catch((error) => {
      useToast().error(error.response.data.message);
    })
    .finally(() => {
      loadingBtn.value = false;
    });
};

</script>
