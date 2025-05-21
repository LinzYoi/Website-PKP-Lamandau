// Utilities
import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

export const useGaleriStore = defineStore("galeri", {
  state: () => ({
    galeris: [],
  }),
  actions: {
    setGaleris(galeris) {
      this.galeris = galeris;
    },
    clearGaleris() {
      this.galeris = [];
    },
    async getAllGaleris() {
      return axios
        .get(apiBaseUrl + "/get-all-galeris", {
          headers: {
            Authorization: `Bearer ${Cookies.get("auth_token")}`,
          },
        })
        .then((response) => {          
          this.setGaleris(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearGaleris();
        });
    },
  },
  getters: {
    getGaleris: (state) => state.galeris || [],
  },
  persist: true,
});
