// src/stores/user.js

import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";
import router from "@/router";
import { useToast } from "vue-toastification";
import config from "../../config";

const apiBaseUrl = config.apiBaseUrl;

export const useUserStore = defineStore("user", {
  state: () => ({
    users: [],
  }),

  actions: {
    setUsers(payload) {
      this.users = payload;
    },
    
    async user() {
      return axios
        .get(`${apiBaseUrl}/user`, {
          headers: { Authorization: `Bearer ${Cookies.get("auth_token")}` },
        })
        .then((response) => {
          this.setUsers(response.data.data);
          // redirect ke home jika belum di sana
          if (router.currentRoute.value.path === "/") {
            router.push("/pkp-lamandau/home");
          }
        })
        .catch((error) => {
          console.error("User not logged in", error);
          router.push("/");
        });
    },

    logout() {
      return axios
        .post(
          `${apiBaseUrl}/logout`,
          {},
          {
            headers: { Authorization: `Bearer ${Cookies.get("auth_token")}` },
          }
        )
        .then((response) => {
          Cookies.remove("auth_token");
          useToast().info(response.data.message);
          router.push("/");
        })
        .catch((error) => {
          useToast().error(error.response.data.message);
        });
    },  
  },

  getters: {
    getUsers: (state) => state.users,    
  },

  persist: true,
});
