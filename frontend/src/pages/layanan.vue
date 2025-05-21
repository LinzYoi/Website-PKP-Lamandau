<template>
  <v-container fluid class="py-2 px-0" style="margin-top: 80px">
    <v-row class="pe-8" align="center" justify="center">
      <v-col cols="8" class="d-flex align-center">
        <v-btn
          class="text-none"
          prepend-icon="mdi-plus"
          color="green"
          rounded="xl"
          text="Tambah Data Layanan"
          @click="openDialog('tambah', {}, addHandler)"
        ></v-btn>
      </v-col>
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
        :items="layanans"
        :search="search"
        :loading="loadingTable"
        loading-text="Loading..."
      >
        <template v-slot:item.no="{ index }">
          {{ index + 1 }}
        </template>
        <template v-slot:item.file_gambar_layanan="{ item }">
          <img
            :src="`${baseUrl}/storage/${item.file_gambar_layanan}`"
            style="width: auto; max-height: 100px"
          />
        </template>
        <template v-slot:item.file_dokumen_layanan="{ item }">
          <a
            :href="`${baseUrl}/storage/${item.file_dokumen_layanan}`"
            target="_blank"
            class="text-decoration-none"
          >
            <v-icon size="30" color="yellow-darken-3">mdi-folder-zip</v-icon>
            <br />
            <span
              class="text-caption font-weight-regular text-decoration-underline text-grey-darken-3"
            >
              Click to download
            </span>
          </a>
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
          <v-btn
            class="text-none ms-1"
            variant="flat"
            color="red"
            rounded="xl"
            size="x-small"
            text="Hapus"
            @click="openDialog('hapus', item, deleteHandler)"
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
          {{
            dialogAction === "tambah"
              ? "Tambah Layanan"
              : dialogAction === "sunting"
              ? "Sunting Layanan"
              : "Hapus Layanan"
          }}
          {{ suntingJudulLayanan }}
        </div>
      </v-card-title>
      <v-card-text class="py-3" v-if="dialogAction !== 'hapus'">
        <v-form @submit.prevent>
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="form.judul_layanan"
                label="Judul"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-textarea
                v-model="form.deskripsi_layanan"
                label="Deskripsi"
                variant="outlined"
                rounded="xl"
                rows="3"
              ></v-textarea>
            </v-col>
            <v-col cols="12">
              <v-file-input
                v-model="form.file_gambar_layanan"
                label="Gambar Layanan"
                variant="outlined"
                rounded="xl"
                accept=".jpg, .jpeg, .png"
                prepend-icon=""
                append-inner-icon="mdi-paperclip"
              ></v-file-input>
            </v-col>
            <v-col cols="12">
              <v-file-input
                v-model="form.file_dokumen_layanan"
                label="Dokumen Layanan (.zip)"
                variant="outlined"
                rounded="xl"
                accept=".zip"
                prepend-icon=""
                append-inner-icon="mdi-paperclip"
              ></v-file-input>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
      <v-card-text class="py-3" v-else>
        <div class="text-h7 font-weight-regular ps-1">
          Apakah ingin hapus layanan ini?
        </div>
      </v-card-text>
      <v-card-actions class="text-center" align="center" justify="center">
        <v-btn size="small" @click="dialog = false">Tidak</v-btn>
        <v-btn
          v-if="dialogAction == 'tambah'"
          size="small"
          @click="tambahLayanan()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'sunting'"
          size="small"
          @click="suntingLayanan()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'hapus'"
          size="small"
          @click="hapusLayanan()"
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

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;
const baseUrl = config.baseUrl;

import { useUserStore } from "@/stores/user";
import { useLayananStore } from "@/stores/layanan";

const layananStore = useLayananStore();
const userStore = useUserStore();

const layanans = computed(() => layananStore.layanans);

const search = ref("");
const loadingTable = ref(false);
const dialog = ref(false);
const dialogAction = ref("");
const dialogActionHandler = ref(null);

const suntingJudulLayanan = ref("");
const form = ref({});

const headers = ref([
  { title: "No", value: "no" },
  { title: "Judul", value: "judul_layanan", sortable: true },
  { title: "Deskripsi", value: "deskripsi_layanan", sortable: true },
  { title: "Gambar Layanan", value: "file_gambar_layanan" },
  { title: "Dokumen Layanan", value: "file_dokumen_layanan" },
  { title: "Aksi", value: "actions", sortable: false },
]);

const openDialog = (action, item, handler) => {
  form.value = { ...item };
  form.value.file_gambar_layanan = null;
  form.value.file_dokumen_layanan = null;
  suntingJudulLayanan.value = item.judul_layanan;

  dialogAction.value = action;
  dialogActionHandler.value = handler;

  dialog.value = true;
};

const tambahLayanan = () => {
  loadingTable.value = true;

  axios
    .post(apiBaseUrl + "/tambah-layanan", form.value, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      layananStore.getAllLayanans();
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

const suntingLayanan = () => {
  loadingTable.value = true;

  axios
    .post(
      apiBaseUrl + "/sunting-layanan/" + form.value.id_layanan,
      form.value,
      {
        headers: {
          Authorization: `Bearer ${Cookies.get("auth_token")}`,
          "Content-Type": "multipart/form-data",
        },
      }
    )
    .then((response) => {
      layananStore.getAllLayanans();
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

const hapusLayanan = () => {
  loadingTable.value = true;

  axios
    .delete(apiBaseUrl + "/hapus-layanan/" + form.value.id_layanan, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
      },
    })
    .then((response) => {
      layananStore.getAllLayanans();
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

onMounted(() => {
  (async () => {
    await layananStore.getAllLayanans();
  })();
});
</script>
