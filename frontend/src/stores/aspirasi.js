// Utilities
import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

export const useAspirasiStore = defineStore("aspirasi", {
  state: () => ({
    aspirasis: [],
  }),
  actions: {
    setAspirasis(aspirasis) {
      this.aspirasis = aspirasis;
    },
    clearAspirasis() {
      this.aspirasis = [];
    },
    async getAllAspirasis() {
      return axios
        .get(apiBaseUrl + "/get-all-aspirasis", {
          headers: {
            Authorization: `Bearer ${Cookies.get("auth_token")}`,
          },
        })
        .then((response) => {          
          this.setAspirasis(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearAspirasis();
        });
    },
  },
  getters: {
    getAspirasis: (state) => state.aspirasis || [],
  },
  persist: true,
});
