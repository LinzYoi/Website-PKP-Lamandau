// Utilities
import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

export const usePegawaiStore = defineStore("pegawai", {
  state: () => ({
    pegawais: [],
  }),
  actions: {
    setpegawais(pegawais) {
      this.pegawais = pegawais;
    },
    clearpegawais() {
      this.pegawais = [];
    },
    async getAllpegawais() {
      return axios
        .get(apiBaseUrl + "/get-all-pegawais", {
        })
        .then((response) => {          
          this.setpegawais(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearpegawais();
        });
    },
  },
  getters: {
    getPegawais: (state) => state.pegawais || [],
  },
  persist: true,
});
