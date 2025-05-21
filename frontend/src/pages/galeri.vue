<template>
  <v-container fluid class="py-2 px-0" style="margin-top: 80px">
    <v-row class="pe-8" align="center" justify="center">
      <v-col cols="8" class="d-flex align-center">
        <v-btn
          class="text-none"
          prepend-icon="mdi-plus"
          color="green"
          rounded="xl"
          text="Tambah Data Galeri"
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
        :items="galeris"
        :search="search"
        :loading="loadingTable"
        loading-text="Loading..."
      >
        <template v-slot:item.no="{ index }">
          {{ index + 1 }}
        </template>
        <template v-slot:item.tanggal_media="{ item }">
          {{ formattedDate(item.tanggal_media) }}
        </template>
        <template v-slot:item.file_gambar_media="{ item }">
          <img
            :src="`${baseUrl}/storage/${item.file_gambar_media}`"
            style="width: auto; max-height: 100px"
          />
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
              ? "Tambah Galeri"
              : dialogAction === "sunting"
              ? "Sunting Galeri"
              : "Hapus Galeri"
          }}
          {{ suntingTanggalGaleri }}
        </div>
      </v-card-title>
      <v-card-text class="py-3" v-if="dialogAction !== 'hapus'">
        <v-form @submit.prevent>
          <v-row>
            <v-col cols="12">
              <v-date-input
                v-model="form.tanggal_media"                                
                :max="new Date().toISOString().split('T')[0]"
                label="Tanggal Galeri"
                variant="outlined"
                rounded="xl"
                locale="id-ID"
                prepend-icon=""
                append-inner-icon="mdi-calendar"
              ></v-date-input>
            </v-col>
            <v-col cols="12">
              <v-file-input
                v-model="form.file_gambar_media"
                label="Gambar Galeri"
                variant="outlined"
                rounded="xl"
                accept=".jpg, .jpeg, .png"
                prepend-icon=""
                append-inner-icon="mdi-paperclip"
              ></v-file-input>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
      <v-card-text class="py-3" v-else>
        <div class="text-h7 font-weight-regular ps-1">
          Apakah ingin hapus galeri ini?
        </div>
      </v-card-text>
      <v-card-actions class="text-center" align="center" justify="center">
        <v-btn size="small" @click="dialog = false">Tidak</v-btn>
        <v-btn
          v-if="dialogAction == 'tambah'"
          size="small"
          @click="tambahGaleri()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'sunting'"
          size="small"
          @click="suntingGaleri()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'hapus'"
          size="small"
          @click="hapusGaleri()"
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
import { useGaleriStore } from "@/stores/galeri";

const galeriStore = useGaleriStore();
const userStore = useUserStore();

const galeris = computed(() => galeriStore.galeris);

const search = ref("");
const loadingTable = ref(false);
const dialog = ref(false);
const dialogAction = ref("");
const dialogActionHandler = ref(null);

const suntingTanggalGaleri = ref("");
const form = ref({});

const headers = ref([
  { title: "No", value: "no" },  
  { title: "Tanggal", value: "tanggal_media", sortable: true },
  { title: "Gambar", value: "file_gambar_media" },
  { title: "Aksi", value: "actions", sortable: false },
]);

const openDialog = (action, item, handler) => {
  form.value = { ...item };
  form.value.file_gambar_media = null;
  suntingTanggalGaleri.value = item.tanggal_media;

  dialogAction.value = action;
  dialogActionHandler.value = handler;

  dialog.value = true;
};

const tambahGaleri = () => {
  loadingTable.value = true;

  // Format tanggal menjadi YYYY-MM-DD
  if (form.value.tanggal_media instanceof Date) {
    const year = form.value.tanggal_media.getFullYear();
    const month = String(form.value.tanggal_media.getMonth() + 1).padStart(
      2,
      "0"
    );
    const day = String(form.value.tanggal_media.getDate()).padStart(2, "0");
    form.value.tanggal_media = `${year}-${month}-${day}`;
  }

  axios
    .post(apiBaseUrl + "/tambah-galeri", form.value, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      galeriStore.getAllGaleris();
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

const suntingGaleri = () => {
  loadingTable.value = true;

  // Format tanggal menjadi YYYY-MM-DD
  if (form.value.tanggal_media instanceof Date) {
    const year = form.value.tanggal_media.getFullYear();
    const month = String(form.value.tanggal_media.getMonth() + 1).padStart(
      2,
      "0"
    );
    const day = String(form.value.tanggal_media.getDate()).padStart(2, "0");
    form.value.tanggal_media = `${year}-${month}-${day}`;
  }

  axios
    .post(apiBaseUrl + "/sunting-galeri/" + form.value.id_galeri, form.value, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      galeriStore.getAllGaleris();
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

const hapusGaleri = () => {
  loadingTable.value = true;

  axios
    .delete(apiBaseUrl + "/hapus-galeri/" + form.value.id_galeri, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
      },
    })
    .then((response) => {
      galeriStore.getAllGaleris();
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

const formattedDate = (date) => {
  const options = { year: "numeric", month: "long", day: "2-digit" };
  return new Date(date).toLocaleDateString("id-ID", options);
};

onMounted(() => {
  (async () => {
    await galeriStore.getAllGaleris();
  })();
});
</script>
