<template>
  <v-container fluid class="py-2 px-0" style="margin-top: 80px">
    <!-- 1) Tombol Cetak Aspirasi ke PDF -->
    <v-row class="pe-8" align="center" justify="center">
      <v-col cols="8" class="d-flex align-center">
        <v-btn
          class="text-none"
          color="red-darken-3"
          rounded="xl"
          text="Cetak Aspirasi ke PDF"
          @click="openDialog('cetak')"
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

    <!-- 2) Tabel Aspirasi -->
    <v-card class="pe-8" tile elevation="0">
      <v-data-table
        :headers="headers"
        :items="aspirasis"
        :search="search"
        :loading="loadingTable"
        loading-text="Loading..."
      >
        <!-- Slot untuk kolom No, Tanggal, Gambar, Actions -->
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
            @click="openDialog('hapus', item)"
          ></v-btn>
        </template>
      </v-data-table>
    </v-card>

    <!-- 3) Dialog Cetak / Hapus Aspirasi -->
    <v-dialog v-model="dialog" max-width="600" persistent>
      <v-card class="py-3" rounded="xl">
        <v-card-title class="d-flex justify-space-between align-center">
          <div class="text-h5 font-weight-medium raleway-font ps-2">
            {{ dialogAction === 'cetak' ? 'Cetak Aspirasi' : 'Hapus Aspirasi' }}
            {{ suntingJudulAspirasi }}
          </div>
        </v-card-title>

        <!-- Isi dialog jika action = "cetak" -->
        <v-card-text class="py-3" v-if="dialogAction === 'cetak'">
          <v-form @submit.prevent>
            <v-row>
              <v-col cols="12">
                <v-select
                  v-model="rentang_waktu"
                  :items="[
                    'Semua Aspirasi',
                    'Hari Ini',
                    'Minggu Ini',
                    'Bulan Ini',
                    'Rentang Tanggal'
                  ]"
                  label="Pilih Rentang Waktu"
                  variant="outlined"
                  rounded="xl"
                />
              </v-col>
              <v-col cols="12">
                <!-- Date‐picker rentang hanya jika pilih "Rentang Tanggal" -->
                <v-date-input
                  v-if="rentang_waktu === 'Rentang Tanggal'"
                  v-model="rentang_waktu_rentang_tanggal"
                  prefix="Mulai - Akhir"
                  placeholder="mm/dd/yyyy - mm/dd/yyyy"
                  label="Pilih Rentang Tanggal"
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
                      @click="rentang_waktu_rentang_tanggal = null"
                    ></v-btn>
                    <v-btn
                      class="text-none"
                      variant="plain"
                      text="Pilih"
                      icon="mdi-check"
                      @click="$refs.datePicker.open = false"
                    ></v-btn>
                  </template>
                </v-date-input>
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>

        <!-- Isi dialog jika action = "hapus" -->
        <v-card-text class="py-3" v-else>
          <div class="text-h7 font-weight-regular ps-1">
            Apakah Anda yakin ingin menghapus aspirasi ini?
          </div>
        </v-card-text>

        <v-card-actions class="text-center" align="center" justify="center">
          <v-btn size="small" @click="dialog = false">Tidak</v-btn>
          <v-btn
            v-if="dialogAction === 'cetak'"
            size="small"
            @click="cetakAspirasi()"
          >Ya</v-btn>
          <v-btn
            v-if="dialogAction === 'hapus'"
            size="small"
            @click="hapusAspirasi()"
          >Ya</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- 4) Drawer Lihat Detail Aspirasi -->
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
            <v-spacer />
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
  </v-container>
</template>

<script setup>
import { onMounted, ref, shallowRef, computed } from "vue";
import { useToast } from "vue-toastification";
import axios from "axios";
import Cookies from "js-cookie";

// 1) Import pdfMake + vfs_fonts
import pdfMake from "pdfmake/build/pdfmake";
import { vfs as pdfFontsVfs } from "pdfmake/build/vfs_fonts";

// Pasang virtual file system ke pdfMake
pdfMake.vfs = pdfFontsVfs;

import config from "../../../config";
const apiBaseUrl = config.apiBaseUrl;  // misal http://localhost:8000/api
const baseUrl     = config.baseUrl;    // misal http://localhost:8000

import { useUserStore } from "@/stores/user";
import { useAspirasiStore } from "@/stores/aspirasi";

const aspirasiStore = useAspirasiStore();
const userStore     = useUserStore();

// data aspirasi dari store
const aspirasis = computed(() => aspirasiStore.aspirasis);

// ====== Reactive state untuk dialog, tabel, form, dll ======
const suntingJudulAspirasi = ref("");
const rentang_waktu        = ref("");     // "Semua Aspirasi", "Hari Ini", "Minggu Ini", "Bulan Ini", "Rentang Tanggal"
const rentang_waktu_rentang_tanggal = shallowRef(null); // array [Date, Date] atau ["YYYY-MM-DD","YYYY-MM-DD"]

const search          = ref("");
const loadingTable    = ref(false);
const dialog          = ref(false);
const dialogAction    = ref("");      // "cetak" atau "hapus"

const lihatDetailAspirasiDrawer = ref(false);
const form            = ref({});

// Header untuk v-data-table
const headers = ref([
  { title: "No",      value: "no" },
  { title: "Judul",   value: "judul_aspirasi", sortable: true },
  { title: "Tanggal", value: "tanggal_aspirasi", sortable: true },
  { title: "Actions", value: "actions", sortable: false }
]);

// Helper: format tanggal (Indonesia)
const formattedDate = (date) => {
  if (!date) return "";
  const d = new Date(date);
  const options = { year: "numeric", month: "long", day: "2-digit" };
  return d.toLocaleDateString("id-ID", options);
};

// ====== Fungsi untuk membuka dialog ======
const openDialog = (action, item = {}) => {
  form.value = { ...item };
  suntingJudulAspirasi.value = item.judul_aspirasi || "";
  dialogAction.value = action;

  if (action === "cetak") {
    rentang_waktu.value = "Semua Aspirasi";
    rentang_waktu_rentang_tanggal.value = null;
  }
  dialog.value = true;
};

// Fungsi buka drawer detail aspirasi
const openLihatDetailAspirasiHandler = (item) => {
  form.value = { ...item };
  lihatDetailAspirasiDrawer.value = true;
};

// ====== Fungsi Hapus Aspirasi (sudah ada) ======
const hapusAspirasi = () => {
  loadingTable.value = true;
  axios
    .delete(`${apiBaseUrl}/hapus-aspirasi/${form.value.id_aspirasi}`, {
      headers: {
        Authorization: `Bearer ${Cookies.get("auth_token")}`
      }
    })
    .then((response) => {
      aspirasiStore.getAllAspirasis();
      dialog.value = false;
      useToast().success(response.data.message);
    })
    .catch((error) => {
      useToast().error(error.response?.data?.message || "Gagal hapus aspirasi");
    })
    .finally(() => {
      setTimeout(() => {
        loadingTable.value = false;
      }, 500);
    });
};

// ====== Fungsi Helper: Convert Gambar URL → Base64 ======
async function getBase64FromUrl(url) {
  try {
    // Karena sudah proxy "/storage" → "http://localhost:8000/storage",
    // cukup panggil relatif "/storage/aspirasi_files/xxx.jpg"
    const response = await fetch(url, { mode: "cors" });
    if (!response.ok) throw new Error(`HTTP error ${response.status}`);
    const blob = await response.blob();
    return await new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onloadend = () => resolve(reader.result);
      reader.onerror = (err) => reject(err);
      reader.readAsDataURL(blob);
    });
  } catch (err) {
    console.warn("Gagal konversi gambar ke Base64:", err);
    return ""; // kosongkan jika gagal
  }
}

// ====== Fungsi Cetak Aspirasi → PDF (dengan gambar dan rentang tanggal) ======
const cetakAspirasi = async () => {
  // Tutup dialog dulu
  dialog.value = false;

  // 1) Tentukan rentang tanggal (start/end)
  let start = null;
  let end   = null;
  const now = new Date();

  switch (rentang_waktu.value) {
    case "Hari Ini":
      start = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0);
      end   = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59);
      break;

    case "Minggu Ini":
      {
        const dayNum = now.getDay(); // 0 = Minggu, 1 = Senin, ..., 6 = Sabtu
        const diffToMonday = dayNum === 0 ? -6 : 1 - dayNum;
        start = new Date(now);
        start.setDate(now.getDate() + diffToMonday);
        start.setHours(0, 0, 0);

        end = new Date(start);
        end.setDate(start.getDate() + 6);
        end.setHours(23, 59, 59);
      }
      break;

    case "Bulan Ini":
      start = new Date(now.getFullYear(), now.getMonth(), 1, 0, 0, 0);
      end   = new Date(now.getFullYear(), now.getMonth() + 1, 0, 23, 59, 59);
      break;

    case "Rentang Tanggal":
      if (
        rentang_waktu_rentang_tanggal.value &&
        Array.isArray(rentang_waktu_rentang_tanggal.value)
      ) {
        // Bisa berupa Date objects atau strings "YYYY-MM-DD"
        let arrayRaw = rentang_waktu_rentang_tanggal.value;

        // Jika Vuetify mengembalikan ["2025-06-03,2025-06-19"] sebagai satu string:
        if (
          arrayRaw.length === 1 &&
          typeof arrayRaw[0] === "string" &&
          arrayRaw[0].includes(",")
        ) {
          arrayRaw = arrayRaw[0].split(",");
        }

        const firstRaw = arrayRaw[0];
        const lastRaw  = arrayRaw[arrayRaw.length - 1];

        let fy, fm, fd, ty, tm, td;
        if (firstRaw instanceof Date) {
          fy = firstRaw.getFullYear();
          fm = firstRaw.getMonth() + 1;
          fd = firstRaw.getDate();
        } else {
          [fy, fm, fd] = firstRaw.split("-").map((x) => parseInt(x, 10));
        }
        if (lastRaw instanceof Date) {
          ty = lastRaw.getFullYear();
          tm = lastRaw.getMonth() + 1;
          td = lastRaw.getDate();
        } else {
          [ty, tm, td] = lastRaw.split("-").map((x) => parseInt(x, 10));
        }
        start = new Date(fy, fm - 1, fd, 0, 0, 0);
        end   = new Date(ty, tm - 1, td, 23, 59, 59);
      }
      break;

    case "Semua Aspirasi":
      start = null;
      end   = null;
      break;

    default:
      start = null;
      end   = null;
  }

  // 2) Filter data aspirasi berdasar start/end
  const filtered = aspirasis.value.filter((item) => {
    if (!start || !end) return true;
    const aspirasiDate = new Date(item.tanggal_aspirasi);
    return aspirasiDate >= start && aspirasiDate <= end;
  });

  // 3) Ambil Base64 semua gambar dari filtered array
  const arrayOfBase64 = await Promise.all(
    filtered.map(async (item) => {
      if (item.file_gambar_aspirasi) {
        // Gunakan path relatif "/storage/aspirasi_files/xxx.jpg"
        // karena proxy Vite akan meneruskannya.
        const fullUrl = `/storage/${item.file_gambar_aspirasi}`;
        const base64 = await getBase64FromUrl(fullUrl);
        return base64; // "" jika gagal
      } else {
        return ""; // tanda tidak ada gambar
      }
    })
  );

  // 4) Susun body tabel PDF, dengan kolom tambahan "Dokumentasi" sebelum "Isi"
  const body = [
    [
      { text: "No",          style: "tableHeader" },
      { text: "Judul",       style: "tableHeader" },
      { text: "Tanggal",     style: "tableHeader" },
      { text: "Nama",        style: "tableHeader" },
      { text: "No Telp",     style: "tableHeader" },
      { text: "E-mail",      style: "tableHeader" },
      { text: "Dokumentasi", style: "tableHeader" },
      { text: "Isi",         style: "tableHeader" }
    ]
  ];

  filtered.forEach((item, idx) => {
    const base64img = arrayOfBase64[idx];
    const cellDokumentasi = base64img
      ? { image: base64img, width: 140 } // Lebar 140 poin
      : "-";

    body.push([
      (idx + 1).toString(),
      item.judul_aspirasi,
      formattedDate(item.tanggal_aspirasi),
      item.nama_pembuat,
      item.no_telp_pembuat,
      item.email_pembuat,
      cellDokumentasi,
      item.isi_aspirasi
    ]);
  });

  // 5) Definisikan dokumen PDF (landscape + A4)
  const docDefinition = {
    pageOrientation: "landscape",
    pageSize: "A4",
    pageMargins: [40, 60, 40, 60],

    content: [
      // Judul utama
      { text: "Laporan Aspirasi", style: "header" },

      // Baris periode
      (() => {
        if (rentang_waktu.value === "Rentang Tanggal" && start && end) {
          return {
            text: `Periode: ${formattedDate(start)} – ${formattedDate(end)}`,
            margin: [0, 0, 0, 10],
          };
        }
        if (rentang_waktu.value === "Semua Aspirasi") {
          return { text: "Periode: Semua Aspirasi", margin: [0, 0, 0, 10] };
        }
        if (rentang_waktu.value) {
          return {
            text: `Periode: ${rentang_waktu.value}`,
            margin: [0, 0, 0, 10],
          };
        }
        return { text: "Periode: Semua Aspirasi", margin: [0, 0, 0, 10] };
      })(),

      // Tabel data
      {
        table: {
          headerRows: 1,
          widths: ["auto", 50, 100, 50, "auto", 90, 140, "*"],
          // Kolom "Dokumentasi" diberi lebar 140 poin
          body: body,
        },
      },
    ],

    styles: {
      header: {
        fontSize: 16,
        bold: true,
        alignment: "center",
        margin: [0, 0, 0, 10],
      },
      tableHeader: {
        bold: true,
        fillColor: "#eeeeee",
      },
    },
    defaultStyle: {
      fontSize: 10,
    },
  };

  // 6) Generate & tampilkan PDF di tab baru
  pdfMake.createPdf(docDefinition).open();
};

// ====== On mounted: ambil data aspirasi ======
onMounted(async () => {
  await aspirasiStore.getAllAspirasis();
});
</script>

<style scoped>
/* Jika perlu styling khusus, Anda bisa tambahkan di sini */
</style>
