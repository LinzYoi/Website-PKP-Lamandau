/**
 * plugins/index.js
 *
 * Automatically included in `./src/main.js`
 */

// Plugins
import vuetify from './vuetify'
import pinia from '@/stores'
import router from '@/router'
import gsap from 'gsap'

import Toast from "vue-toastification";
import "vue-toastification/dist/index.css";
const options = {
  transition: "Vue-Toastification__bounce",
  maxToasts: 1000,
  newestOnTop: true,
  timeout: 4000,
  closeOnClick: true,
  closeButton: false, 
  icon: false, 
  hideProgressBar: false,
  position: "top-center",
};

export function registerPlugins (app) {
  app
    .use(vuetify)
    .use(router)
    .use(pinia)
    .use(gsap)
    .use(Toast, options)    
}
