// Utilities
import { defineStore } from "pinia";
import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;

export const useLayananStore = defineStore("layanan", {
  state: () => ({
    layanans: [],
  }),
  actions: {
    setLayanans(layanans) {
      this.layanans = layanans;
    },
    clearLayanans() {
      this.layanans = [];
    },
    getAllLayanans() {
      axios
        .get(apiBaseUrl + "/get-all-layanans", {
          headers: {
            Authorization: `Bearer ${Cookies.get("auth_token")}`,
          },
        })
        .then((response) => {          
          this.setLayanans(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearLayanans();
        });
    },
  },
  getters: {
    getLayanans: (state) => state.layanans || [],
  },
  persist: true,
});
