// Utilities
import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

export const useBeritaStore = defineStore("berita", {
  state: () => ({
    beritas: [],
  }),
  actions: {
    setBeritas(beritas) {
      this.beritas = beritas;
    },
    clearBeritas() {
      this.beritas = [];
    },
    async getAllBeritas() {
      return axios
        .get(apiBaseUrl + "/get-all-beritas", {
          headers: {
            Authorization: `Bearer ${Cookies.get("auth_token")}`,
          },
        })
        .then((response) => {          
          this.setBeritas(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearBeritas();
        });
    },
  },
  getters: {
    getBeritas: (state) => state.beritas || [],
  },
  persist: true,
});
