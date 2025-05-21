<template>
  <v-container fluid class="py-2 px-0" style="margin-top: 80px">
    <v-row class="pe-8" align="center" justify="center">
      <v-col cols="8" class="d-flex align-center">
        <v-btn
          class="text-none"
          prepend-icon="mdi-plus"
          color="green"
          rounded="xl"
          text="Tambah Data Pegawai"
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
        :items="pegawais"
        :search="search"
        :loading="loadingTable"
        loading-text="Loading..."
      >
        <template v-slot:item.no="{ index }">
          {{ index + 1 }}
        </template>
        <template v-slot:item.file_pegawai="{ item }">
          <img
            :src="`${baseUrl}/storage/${item.file_pegawai}`"
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
              ? "Tambah Pegawai"
              : dialogAction === "sunting"
              ? "Sunting Pegawai"
              : "Hapus Pegawai"
          }}
          {{ suntingNama }}
        </div>
      </v-card-title>
      <v-card-text class="py-3" v-if="dialogAction !== 'hapus'">
        <v-form @submit.prevent>
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="form.nama"
                label="Nama"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="form.jabatan"
                label="Jabatan"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="form.nip"
                label="NIP"
                variant="outlined"
                rounded="xl"
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-select
                v-model="form.status"
                :items="['Aktif', 'Mutasi', 'Pensiun']"
                label="Status"
                variant="outlined"
                rounded="xl"
              ></v-select>
            </v-col>
            <v-col cols="12">
              <v-file-input
                v-model="form.file_pegawai"
                label="Foto"
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
          Apakah ingin hapus pegawai ini?
        </div>
      </v-card-text>
      <v-card-actions class="text-center" align="center" justify="center">
        <v-btn size="small" @click="dialog = false">Tidak</v-btn>
        <v-btn
          v-if="dialogAction == 'tambah'"
          size="small"
          @click="tambahPegawai()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'sunting'"
          size="small"
          @click="suntingPegawai()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'hapus'"
          size="small"
          @click="hapusPegawai()"
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
import { usePegawaiStore } from "@/stores/pegawai";

const pegawaiStore = usePegawaiStore();
const userStore = useUserStore();

const pegawais = computed(() => pegawaiStore.pegawais);

const search = ref("");
const loadingTable = ref(false);
const dialog = ref(false);
const dialogAction = ref("");
const dialogActionHandler = ref(null);

const suntingNama = ref("");
const form = ref({});

const headers = ref([
  { title: "No", value: "no" },
  { title: "Nama", value: "nama", sortable: true },
  { title: "Jabatan", value: "jabatan", sortable: true },
  { title: "NIP", value: "nip", sortable: true },
  { title: "Status", value: "status", sortable: true },
  { title: "Foto", value: "file_pegawai" },
  { title: "Aksi", value: "actions", sortable: false },
]);

const openDialog = (action, item, handler) => {
  form.value = { ...item };
  form.value.file_pegawai = null;
  suntingNama.value = item.nama;

  dialogAction.value = action;
  dialogActionHandler.value = handler;

  dialog.value = true;
};

const tambahPegawai = () => {
  loadingTable.value = true;

  axios
    .post(apiBaseUrl + "/tambah-pegawai", form.value, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      pegawaiStore.getAllpegawais();
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

const suntingPegawai = () => {
  loadingTable.value = true;

  axios
    .post(
      apiBaseUrl + "/sunting-pegawai/" + form.value.id_pegawai,
      form.value,
      {
        headers: {
          Authorization: `Bearer ${Cookies.get("auth_token")}`,
          "Content-Type": "multipart/form-data",
        },
      }
    )
    .then((response) => {
      pegawaiStore.getAllpegawais();
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

const hapusPegawai = () => {
  loadingTable.value = true;

  axios
    .delete(apiBaseUrl + "/hapus-pegawai/" + form.value.id_pegawai, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
      },
    })
    .then((response) => {
      pegawaiStore.getAllpegawais();
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
    await pegawaiStore.getAllpegawais();
  })();
});
</script>
