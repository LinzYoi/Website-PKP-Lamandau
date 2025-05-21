<template>
  <v-container fluid class="py-2 px-0" style="margin-top: 80px">
    <v-row class="pe-8" align="center" justify="center">
      <v-col cols="8" class="d-flex align-center">
        <v-btn
          class="text-none"
          prepend-icon="mdi-plus"
          color="green"
          rounded="xl"
          text="Tambah Data Berita"
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
        :items="beritas"
        :search="search"
        :loading="loadingTable"
        loading-text="Loading..."
      >
        <template v-slot:item.no="{ index }">
          {{ index + 1 }}
        </template>
        <template v-slot:item.tanggal_berita="{ item }">
          {{ formattedDate(item.tanggal_berita) }}
        </template>
        <template v-slot:item.file_gambar_berita="{ item }">
          <img
            :src="`${baseUrl}/storage/${item.file_gambar_berita}`"
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
              ? "Tambah Berita"
              : dialogAction === "sunting"
              ? "Sunting Berita"
              : "Hapus Berita"
          }}
          {{ suntingJudulBerita }}
        </div>
      </v-card-title>
      <v-card-text class="py-3" v-if="dialogAction !== 'hapus'">
        <v-form @submit.prevent>
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="form.judul_berita"
                label="Judul"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-textarea
                v-model="form.deskripsi_berita"
                label="Deskripsi"
                variant="outlined"
                rounded="xl"
                rows="3"
              ></v-textarea>
            </v-col>
            <v-col cols="12">
              <v-date-input
                v-model="form.tanggal_berita"                                
                :max="new Date().toISOString().split('T')[0]"
                label="Tanggal Berita"
                variant="outlined"
                rounded="xl"
                locale="id-ID"
                prepend-icon=""
                append-inner-icon="mdi-calendar"
              ></v-date-input>
            </v-col>
            <v-col cols="12">
              <v-file-input
                v-model="form.file_gambar_berita"
                label="Gambar Berita"
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
          Apakah ingin hapus berita ini?
        </div>
      </v-card-text>
      <v-card-actions class="text-center" align="center" justify="center">
        <v-btn size="small" @click="dialog = false">Tidak</v-btn>
        <v-btn
          v-if="dialogAction == 'tambah'"
          size="small"
          @click="tambahBerita()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'sunting'"
          size="small"
          @click="suntingBerita()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'hapus'"
          size="small"
          @click="hapusBerita()"
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
import { useBeritaStore } from "@/stores/berita";

const beritaStore = useBeritaStore();
const userStore = useUserStore();

const beritas = computed(() => beritaStore.beritas);

const search = ref("");
const loadingTable = ref(false);
const dialog = ref(false);
const dialogAction = ref("");
const dialogActionHandler = ref(null);

const suntingJudulBerita = ref("");
const form = ref({});

const headers = ref([
  { title: "No", value: "no" },
  { title: "Judul", value: "judul_berita", sortable: true },
  { title: "Deskripsi", value: "deskripsi_berita", sortable: true },
  { title: "Tanggal", value: "tanggal_berita", sortable: true },
  { title: "Gambar", value: "file_gambar_berita" },
  { title: "Aksi", value: "actions", sortable: false },
]);

const openDialog = (action, item, handler) => {
  form.value = { ...item };
  form.value.file_gambar_berita = null;
  suntingJudulBerita.value = item.judul_berita;

  dialogAction.value = action;
  dialogActionHandler.value = handler;

  dialog.value = true;
};

const tambahBerita = () => {
  loadingTable.value = true;

  // Format tanggal menjadi YYYY-MM-DD
  if (form.value.tanggal_berita instanceof Date) {
    const year = form.value.tanggal_berita.getFullYear();
    const month = String(form.value.tanggal_berita.getMonth() + 1).padStart(
      2,
      "0"
    );
    const day = String(form.value.tanggal_berita.getDate()).padStart(2, "0");
    form.value.tanggal_berita = `${year}-${month}-${day}`;
  }

  axios
    .post(apiBaseUrl + "/tambah-berita", form.value, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      beritaStore.getAllBeritas();
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

const suntingBerita = () => {
  loadingTable.value = true;

  // Format tanggal menjadi YYYY-MM-DD
  if (form.value.tanggal_berita instanceof Date) {
    const year = form.value.tanggal_berita.getFullYear();
    const month = String(form.value.tanggal_berita.getMonth() + 1).padStart(
      2,
      "0"
    );
    const day = String(form.value.tanggal_berita.getDate()).padStart(2, "0");
    form.value.tanggal_berita = `${year}-${month}-${day}`;
  }

  axios
    .post(apiBaseUrl + "/sunting-berita/" + form.value.id_berita, form.value, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      beritaStore.getAllBeritas();
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

const hapusBerita = () => {
  loadingTable.value = true;

  axios
    .delete(apiBaseUrl + "/hapus-berita/" + form.value.id_berita, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
      },
    })
    .then((response) => {
      beritaStore.getAllBeritas();
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
    await beritaStore.getAllBeritas();
  })();
});
</script>
