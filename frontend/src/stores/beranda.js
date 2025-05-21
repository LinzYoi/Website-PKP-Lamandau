// Utilities
import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

export const useBerandaStore = defineStore("beranda", {
  state: () => ({
    berandas: [],
  }),
  actions: {
    setBerandas(berandas) {
      this.berandas = berandas;
    },
    clearBerandas() {
      this.berandas = [];
    },
    async getAllBerandas() {
      return axios
        .get(apiBaseUrl + "/get-all-berandas", {
          headers: {
            Authorization: `Bearer ${Cookies.get("auth_token")}`,
          },
        })
        .then((response) => {          
          this.setBerandas(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearBerandas();
        });
    },
  },
  getters: {
    getBerandas: (state) => state.berandas || [],
  },
  persist: true,
});
