// Utilities
import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

export const useProdukHukumStore = defineStore("produkHukum", {
  state: () => ({
    produkHukums: [],
  }),
  actions: {
    setProdukHukums(produkHukums) {
      this.produkHukums = produkHukums;
    },
    clearProdukHukums() {
      this.produkHukums = [];
    },
    async getAllProdukHukums() {
      return axios
        .get(apiBaseUrl + "/get-all-produk-hukums", {
          headers: {
            Authorization: `Bearer ${Cookies.get("auth_token")}`,
          },
        })
        .then((response) => {          
          this.setProdukHukums(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearProdukHukums();
        });
    },
  },
  getters: {
    getProdukHukums: (state) => state.produkHukums || [],
  },
  persist: true,
});
