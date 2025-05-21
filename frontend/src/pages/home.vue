<template>
  <v-container fluid class="pa-0">
    <v-row class="fill-height mt-16">
      <v-col cols="12">
        INI DASHBOARD
        <pre>{{ useUserStore().getUsers }}</pre>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { onMounted, computed } from "vue";
import { useUserStore } from "@/stores/user";

import config from "../../config";
const baseUrl = config.baseUrl;

const userStore = useUserStore();
onMounted(async () => {});

const user = computed(() => userStore.getUsers);
</script>
