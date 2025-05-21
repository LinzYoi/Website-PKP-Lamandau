<template>
  <v-container fluid class="py-2 px-0" style="margin-top: 80px">
    <v-row class="pe-8" align="center" justify="center">
      <v-col cols="8" class="d-flex align-center">
        <v-btn
          class="text-none"
          color="red-darken-3"
          rounded="xl"
          text="Cetak Aspirasi ke PDF"
          @click="openDialog('cetak', {}, cetakHandler)"
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
        :items="aspirasis"
        :search="search"
        :loading="loadingTable"
        loading-text="Loading..."
      >
        <template v-slot:item.no="{ index }">
          {{ index + 1 }}
        </template>
        <template v-slot:item.tanggal_aspirasi="{ item }">
          {{ formattedDate(item.tanggal_aspirasi) }}
        </template>
        <template v-slot:item.file_gambar_aspirasi="{ item }">
          <img
            :src="`${baseUrl}/storage/${item.file_gambar_aspirasi}`"
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
            text="Lihat Detail"
            @click="openLihatDetailAspirasiHandler(item)"
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

  <!-- dialog cetak, delete -->
  <v-dialog v-model="dialog" max-width="600" persistent>
    <v-card class="py-3" rounded="xl">
      <v-card-title class="d-flex justify-space-between align-center">
        <div class="text-h5 font-weight-medium raleway-font ps-2">
          {{ dialogAction === "cetak" ? "Cetak Aspirasi" : "Hapus Aspirasi" }}
          {{ suntingJudulAspirasi }}
        </div>
      </v-card-title>
      <v-card-text class="py-3" v-if="dialogAction !== 'hapus'">
        <v-form @submit.prevent>
          <v-row>
            <v-col cols="12">
              <v-select
                v-model="rentang_waktu"
                :items="[
                  'Hari Ini',
                  'Minggu Ini',
                  'Bulan Ini',
                  'Rentang Tanggal',
                ]"
                label="Pilih Rentang Waktu"
                variant="outlined"
                rounded="xl"
              />
            </v-col>
            <v-col cols="12">
              <v-date-input
                v-if="rentang_waktu === 'Rentang Tanggal'"
                v-model="rentang_waktu_rentang_tanggal"
                prefix="Mulai - Akhir"
                placeholder="mm/dd/yyyy - mm/dd/yyyy"
                label="Plih rentang tanggal"
                variant="outlined"
                rounded="xl"
                multiple="range"
                prepend-icon=""
                prepend-inner-icon="mdi-calendar"
              >
                <template #actions>
                  <v-btn
                    class="text-none"
                    variant="plain"
                    text="Tutup"
                    icon="mdi-close"
                    @click="lihatDetailAspirasiDrawer = false"
                  ></v-btn>
                  <v-btn
                    class="text-none"
                    variant="plain"
                    text="Pilih"
                    icon="mdi-check"
                    @click="lihatDetailAspirasiDrawer = false"
                  ></v-btn>
                </template>
              </v-date-input>
            </v-col>
          </v-row>
        </v-form>
      </v-card-text>
      <v-card-text class="py-3" v-else>
        <div class="text-h7 font-weight-regular ps-1">
          Apakah ingin hapus aspirasi ini?
        </div>
      </v-card-text>
      <v-card-actions class="text-center" align="center" justify="center">
        <v-btn size="small" @click="dialog = false">Tidak</v-btn>
        <v-btn
          v-if="dialogAction == 'cetak'"
          size="small"
          @click="cetakAspirasi()"
          >Ya</v-btn
        >
        <v-btn
          v-if="dialogAction == 'hapus'"
          size="small"
          @click="hapusAspirasi()"
          >Ya</v-btn
        >
      </v-card-actions>
    </v-card>
  </v-dialog>

  <v-navigation-drawer
    v-model="lihatDetailAspirasiDrawer"
    temporary
    dark
    class="bg-grey-darken-3"
    clipped
    width="600"
    location="right"
    z-index="9999"
  >
    <v-list class="pt-3">
      <v-list-item class="ps-5 pe-1">
        <div class="d-flex align-center">
          <span class="font-weight-medium">
            <span class="text-white">Detail Aspirasi</span>
          </span>

          <v-spacer></v-spacer>

          <v-btn
            class="text-none ms-2"
            variant="plain"
            text="Tutup"
            icon="mdi-close"
            @click="lihatDetailAspirasiDrawer = false"
          ></v-btn>
        </div>
      </v-list-item>
    </v-list>

    <v-divider class="mb-4" />

    <v-list class="pt-0">
      <v-list-item class="ps-5 pe-1">
        <v-row>
          <v-col cols="3">Judul</v-col>
          <v-col cols="9">: {{ form.judul_aspirasi }}</v-col>
          <v-col cols="3">Tanggal</v-col>
          <v-col cols="9">: {{ formattedDate(form.tanggal_aspirasi) }}</v-col>
          <v-col cols="3">Isi</v-col>
          <v-col cols="9">: {{ form.isi_aspirasi }}</v-col>
          <v-col cols="3">Dokumentasi</v-col>
          <v-col cols="9">
            :&nbsp;
            <img
              :src="`${baseUrl}/storage/${form.file_gambar_aspirasi}`"
              style="width: auto; max-height: 300px"
            />
          </v-col>
          <v-col cols="3">Dibuat oleh</v-col>
          <v-col cols="9">: {{ form.nama_pembuat }}</v-col>
          <v-col cols="3">No Telp</v-col>
          <v-col cols="9">: {{ form.no_telp_pembuat }}</v-col>
          <v-col cols="3">E-mail</v-col>
          <v-col cols="9">: {{ form.email_pembuat }}</v-col>
        </v-row>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script setup>
import { onMounted, ref, shallowRef, computed } from "vue";
import { useToast } from "vue-toastification";

import axios from "axios";
import Cookies from "js-cookie";

import config from "../../config";
const apiBaseUrl = config.apiBaseUrl;
const baseUrl = config.baseUrl;

import { useUserStore } from "@/stores/user";
import { useAspirasiStore } from "@/stores/aspirasi";

const aspirasiStore = useAspirasiStore();
const userStore = useUserStore();

const aspirasis = computed(() => aspirasiStore.aspirasis);

const suntingJudulAspirasi = ref("");
const rentang_waktu = ref("");
const rentang_waktu_rentang_tanggal = shallowRef(null);

const search = ref("");
const loadingTable = ref(false);
const dialog = ref(false);
const dialogAction = ref("");
const dialogActionHandler = ref(null);

const lihatDetailAspirasiDrawer = ref(false);

const form = ref({});

const headers = ref([
  { title: "No", value: "no" },
  { title: "Judul", value: "judul_aspirasi", sortable: true },
  { title: "Tanggal", value: "tanggal_aspirasi", sortable: true },
  { title: "Actions", value: "actions", sortable: false },
]);

const openDialog = (action, item, handler) => {
  form.value = { ...item };
  suntingJudulAspirasi.value = item.judul_aspirasi;

  dialogAction.value = action;
  dialogActionHandler.value = handler;

  dialog.value = true;
};

const openLihatDetailAspirasiHandler = (item) => {
  form.value = { ...item };

  lihatDetailAspirasiDrawer.value = true;
};

const tambahAspirasi = () => {
  loadingTable.value = true;

  axios
    .post(apiBaseUrl + "/tambah-aspirasi", form.value, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
        "Content-Type": "multipart/form-data",
      },
    })
    .then((response) => {
      aspirasiStore.getAllAspirasis();
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

const hapusAspirasi = () => {
  loadingTable.value = true;

  axios
    .delete(apiBaseUrl + "/hapus-aspirasi/" + form.value.id_aspirasi, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`,
      },
    })
    .then((response) => {
      aspirasiStore.getAllAspirasis();
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
    await aspirasiStore.getAllAspirasis();
  })();
});
</script>
