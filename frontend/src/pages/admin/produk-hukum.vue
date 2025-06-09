<template>
  <v-container fluid class="py-2 px-0" style="margin-top: 80px">
    <v-row class="pe-8" align="center" justify="center">
      <v-col cols="8" class="d-flex align-center">
        <v-btn
          class="text-none"
          prepend-icon="mdi-plus"
          color="green"
          rounded="xl"
          text="Tambah Data Produk Hukum"
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
        :items="produkHukums"
        :search="search"
        :loading="loadingTable"
        loading-text="Loading..."
      >
        <template v-slot:item.no="{ index }">
          {{ index + 1 }}
        </template>
        <template v-slot:item.file_dokumen_produk_hukum="{ item }">
          <a
            :href="`${baseUrl}/storage/${item.file_dokumen_produk_hukum}`"
            target="_blank"
            class="text-decoration-none"
          >
            <v-icon
              v-if="item.file_dokumen_produk_hukum.split('.').pop() === 'zip'"
              size="30"
              color="yellow-darken-3"
              >mdi-folder-zip</v-icon
            >
            <v-icon
              v-else-if="
                item.file_dokumen_produk_hukum.split('.').pop() === 'pdf'
              "
              size="30"
              color="red-darken-2"
              >mdi-file-pdf-box</v-icon
            >
            <v-icon
              v-else-if="
                item.file_dokumen_produk_hukum.split('.').pop() === 'doc'
              "
              size="30"
              color="blue-darken-3"
              >mdi-file-word</v-icon
            >
            <v-icon
              v-else-if="
                item.file_dokumen_produk_hukum.split('.').pop() === 'docx'
              "
              size="30"
              color="blue-darken-3"
              >mdi-file-word</v-icon
            >
            <br />
            <span
              class="text-caption font-weight-regular text-decoration-underline text-grey-darken-3"
            >
              Unduh disini
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
              ? "Tambah Produk Hukum"
              : dialogAction === "sunting"
              ? "Sunting Produk Hukum"
              : "Hapus Produk Hukum"
          }}
          {{ suntingJudulProdukHukum }}
        </div>
      </v-card-title>
      <v-card-text class="py-3" v-if="dialogAction !== 'hapus'">
        <v-form @submit.prevent>
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="form.bentuk_produk_hukum"
                label="Bentuk"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="form.judul_produk_hukum"
                label="Judul"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-select
                v-model="form.tahun_produk_hukum"
                label="Tahun"
                variant="outlined"
                rounded="xl"
                :items="[
                  '2015',
                  '2016',
                  '2017',
                  '2018',
                  '2019',
                  '2020',
                  '2021',
                  '2022',
                  '2023',
                  '2024',
                  '2025',
                  '2026',
                  '2027',
                  '2028',
                  '2029',
                  '2030',
                ]"
              ></v-select>
            </v-col>
            <v-col cols="12">
              <v-file-input
                v-model="form.file_dokumen_produk_hukum"
                label="Dokumen (.zip, .pdf, .doc, .docx)"
                variant="outlined"
                rounded="xl"
                accept=".zip, .pdf, .doc, .docx"
                prepend-icon=""
                append-inner-icon="mdi-paperclip"
              ></v-file-input>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
      <v-card-text class="py-3" v-else>
        <div class="text-h7 font-weight-regular ps-1">
          Apakah ingin hapus produk hukum ini?
        </div>
      </v-card-text>
      <v-card-actions class="text-center" align="center" justify="center">
        <v-btn size="small" @click="dialog = false">Tidak</v-btn>
        <v-btn
          v-if="dialogAction == 'tambah'"
          size="small"
          @click="tambahProdukHukum()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'sunting'"
          size="small"
          @click="suntingProdukHukum()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'hapus'"
          size="small"
          @click="hapusProdukHukum()"
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
import { useProdukHukumStore } from "@/stores/produkHukum";

const produkHukumStore = useProdukHukumStore();
const userStore = useUserStore();

const produkHukums = computed(() => produkHukumStore.produkHukums);

const search = ref("");
const loadingTable = ref(false);
const dialog = ref(false);
const dialogAction = ref("");
const dialogActionHandler = ref(null);

const suntingJudulProdukHukum = ref("");
const form = ref({});

const headers = ref([
  { title: "No", value: "no" },
  { title: "Bentuk", value: "bentuk_produk_hukum", sortable: true },
  { title: "Judul", value: "judul_produk_hukum", sortable: true },
  { title: "Tahun", value: "tahun_produk_hukum", sortable: true },
  { title: "Dokumen", value: "file_dokumen_produk_hukum" },
  { title: "Aksi", value: "actions", sortable: false },
]);

const openDialog = (action, item, handler) => {
  form.value = { ...item };
  form.value.file_dokumen_produk_hukum = null;
  suntingJudulProdukHukum.value = item.judul_produk_hukum;

  dialogAction.value = action;
  dialogActionHandler.value = handler;

  dialog.value = true;
};

const tambahProdukHukum = () => {
  loadingTable.value = true;

  axios
    .post(apiBaseUrl + "/tambah-produk-hukum", form.value, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      produkHukumStore.getAllProdukHukums();
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

const suntingProdukHukum = () => {
  loadingTable.value = true;

  axios
    .post(
      apiBaseUrl + "/sunting-produk-hukum/" + form.value.id_produk_hukum,
      form.value,
      {
        headers: {
          Authorization: `Bearer ${Cookies.get("auth_token")}`,
          "Content-Type": "multipart/form-data",
        },
      }
    )
    .then((response) => {
      produkHukumStore.getAllProdukHukums();
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

const hapusProdukHukum = () => {
  loadingTable.value = true;

  axios
    .delete(apiBaseUrl + "/hapus-produk-hukum/" + form.value.id_produk_hukum, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
      },
    })
    .then((response) => {
      produkHukumStore.getAllProdukHukums();
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
    await produkHukumStore.getAllProdukHukums();
  })();
});
</script>
