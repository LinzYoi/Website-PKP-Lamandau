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
    getAllBeritas() {
      axios
        .get(apiBaseUrl + "/get-all-beritas", {
        })
        .then((response) => {          
          this.setBeritas(response.data.data);
        })
        .catch((error) => {
          console.error(error.response.data);
          this.clearBeritas();
        });
    },
    getBeritaBySlug(slug) {
      const slugify = (text) => {
        return text
          .toString()
          .toLowerCase()
          .trim()
          .replace(/\s+/g, '-')
          .replace(/[^\w\-]+/g, '')
          .replace(/\-\-+/g, '-')
          .replace(/^-+/, '')
          .replace(/-+$/, '');
      };

      return this.beritas.find((b) => slugify(b.judul_berita) === slug) || null;
    }
  },
  getters: {
    getBeritas: (state) => state.beritas || [],
  },
  persist: true,
});
