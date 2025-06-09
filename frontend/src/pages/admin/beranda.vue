<template>
  <v-container fluid class="py-2 px-0" style="margin-top: 80px">
    <v-row class="pe-8" align="center" justify="center">
      <v-col cols="8" class="d-flex align-center"> </v-col>
      <v-col cols="4" class="d-flex align-center justify-end">
        <v-text-field
          style="border-radius: 50px"
          class="bg-grey-lighten-3"
          v-model="search"
          label="Cari"
          prepend-inner-icon="mdi-magnify"
          variant="outlined"
          density="compact"
          rounded="xl"
          hide-details
          single-line
        ></v-text-field>
      </v-col>
    </v-row>

    <v-card class="pe-8" tile elevation="0">
      <v-data-table
        :headers="headers"
        :items="berandas"
        :search="search"
        :loading="loadingTable"
        loading-text="Loading..."
      >
        <template v-slot:item.no="{ index }">
          {{ index + 1 }}
        </template>
        <template v-slot:item.file_beranda="{ item }">
          <div v-if="item.file_beranda">
            <img
              v-if="isImage(item.file_beranda)"
              :src="`${baseUrl}/storage/${item.file_beranda}`"
              style="width: auto; max-height: 100px"
            />
            <video
              v-else
              :src="`${baseUrl}/storage/${item.file_beranda}`"
              style="max-width: 200px; max-height: 100px"
              controls
            ></video>
          </div>
        </template>
        <template v-slot:item.actions="{ item }">
          <v-btn
            class="text-none"
            variant="flat"
            color="yellow"
            rounded="xl"
            size="x-small"
            text="Sunting"
            @click="openDialog('sunting', item, editHandler)"
          ></v-btn>
        </template>
      </v-data-table>
    </v-card>
  </v-container>

  <!-- dialog add, edit, delete -->
  <v-dialog v-model="dialog" max-width="600" persistent>
    <v-card class="py-3" rounded="xl">
      <v-card-title class="d-flex justify-space-between align-center">
        <div class="text-h5 font-weight-medium raleway-font ps-2">
          Sunting Beranda No {{ form.id_beranda }}
        </div>
      </v-card-title>
      <v-card-text class="py-3" v-if="dialogAction !== 'hapus'">
        <v-form @submit.prevent>
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="form.judul_beranda"
                label="Judul"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-textarea
                v-model="form.deskripsi_beranda"
                label="Deskripsi"
                variant="outlined"
                rounded="xl"
                rows="3"
              ></v-textarea>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="form.nama"
                label="Nama"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-file-input
                v-model="form.file_beranda"
                label="Gambar/Video Beranda"
                variant="outlined"
                rounded="xl"
                accept=".jpg, .jpeg, .png, .mp4, .mov"
                prepend-icon=""
                append-inner-icon="mdi-paperclip"
              ></v-file-input>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
      <v-card-actions class="text-center" align="center" justify="center">
        <v-btn size="small" @click="dialog = false">Tidak</v-btn>
        <v-btn
          v-if="dialogAction == 'sunting'"
          size="small"
          @click="suntingBeranda()"
          >Ya</v-btn
        >
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import { useToast } from "vue-toastification";

import axios from "axios";
import Cookies from "js-cookie";

import config from "../../../config";
const apiBaseUrl = config.apiBaseUrl;
const baseUrl = config.baseUrl;

import { useUserStore } from "@/stores/user";
import { useBerandaStore } from "@/stores/beranda";

const berandaStore = useBerandaStore();
const userStore = useUserStore();

const berandas = computed(() => berandaStore.berandas);

const search = ref("");
const loadingTable = ref(false);
const dialog = ref(false);
const dialogAction = ref("");
const dialogActionHandler = ref(null);

const form = ref({});

const headers = ref([
  { title: "No", value: "no" },
  { title: "Judul Beranda", value: "judul_beranda", sortable: true },
  { title: "Deskripsi Beranda", value: "deskripsi_beranda", sortable: true },
  { title: "Nama", value: "nama", sortable: true },
  { title: "Gambar/Video Beranda", value: "file_beranda" },
  { title: "Aksi", value: "actions", sortable: false },
]);

const openDialog = (action, item, handler) => {
  form.value = { ...item };
  form.value.file_beranda = null;

  dialogAction.value = action;
  dialogActionHandler.value = handler;

  dialog.value = true;
};

const suntingBeranda = () => {
  loadingTable.value = true;

  axios
    .post(
      apiBaseUrl + "/sunting-beranda/" + form.value.id_beranda,
      form.value,
      {
        headers: {
          Authorization: `Bearer ${Cookies.get("auth_token")}`,
          "Content-Type": "multipart/form-data",
        },
      }
    )
    .then((response) => {
      berandaStore.getAllBerandas();
      dialog.value = false;
      useToast().success(response.data.message);
    })
    .catch((error) => {
      console.log(error.response.data.message);
      useToast().error(error.response.data.message);
    })
    .finally(() => {
      setTimeout(() => {
        loadingTable.value = false;
      }, 500);
    });
};

const isImage = (filename) => {
  return /\.(jpg|jpeg|png|gif)$/i.test(filename);
};

const isVideo = (filename) => {
  return /\.(mp4|mov)$/i.test(filename);
};

onMounted(() => {
  (async () => {
    await berandaStore.getAllBerandas();
  })();
});
</script>
