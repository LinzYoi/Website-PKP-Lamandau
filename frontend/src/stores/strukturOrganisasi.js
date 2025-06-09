// Utilities
import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

export const useStrukturOrganisasiStore = defineStore("strukturOrganisasi", {
  state: () => ({
    strukturOrganisasis: [],
  }),
  actions: {
    setStrukturOrganisasis(strukturOrganisasis) {
      this.strukturOrganisasis = strukturOrganisasis;
    },
    clearStrukturOrganisasis() {
      this.strukturOrganisasis = [];
    },
    async getAllStrukturOrganisasis() {
      return axios
        .get(apiBaseUrl + "/get-all-struktur-organisasis", {
        })
        .then((response) => {          
          this.setStrukturOrganisasis(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearStrukturOrganisasis();
        });
    },
  },
  getters: {
    getStrukturOrganisasis: (state) => state.strukturOrganisasis || [],
  },
  persist: true,
});
