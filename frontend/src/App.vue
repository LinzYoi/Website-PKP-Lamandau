<template>
  <v-app>
    <router-view></router-view>
  </v-app>
</template>

<script setup>
import { onMounted, onUnmounted, onBeforeMount } from "vue";
import { useUserStore } from "./stores/user";
import config from "../config";

const userStore = useUserStore();


// onMounted(async () => {
//   await userStore.user();
// });

onBeforeMount(() => {
  userStore.user();
});

</script>


<style scoped>
</style>
