<template>
  <v-container fluid>
    <v-row align="center" justify="center">
      <v-col cols="12" sm="10">
        <!-- Title -->
        <div class="text-h4 text-sm-h4 text-md-h3 text-lg-h2 text-center text-sea_links_color font-weight-bold raleway-font mb-4" style="line-height: normal;">
          PKP LAMANDAU
        </div>

        <!-- Sign In Button -->
        <div class="text-center mt-12">
          <v-btn
            color="sea_links_color"
            rounded="lg"
            block
            @click="router.push('/login')"
          >
            Sign In
          </v-btn>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import router from '@/router';

const loading = ref(true);

onMounted(async () => {
});
</script>

<style scoped>

</style>