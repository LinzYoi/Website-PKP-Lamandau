/**
 * plugins/vuetify.js
 *
 * Framework documentation: https://vuetifyjs.com`
 */

// Styles
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'
import { VDateInput } from 'vuetify/labs/components'
import { VTimePicker } from 'vuetify/labs/VTimePicker'

// Composables
import { createVuetify } from 'vuetify'

// https://vuetifyjs.com/en/introduction/why-vuetify/#feature-guides
export default createVuetify({
  theme: {
    defaultTheme: 'light',
    themes: {
      light: {
        colors: {
          primary: '#1976D2',
          secondary: '#424242',
          accent: '#82B1FF',
          error: '#FF5252',
          info: '#2196F3',
          success: '#4CAF50',
          warning: '#FFC107'
        }
      },
      dark: {
        colors: {
          primary: '#121212',
          secondary: '#1E1E1E',
          accent: '#BB86FC',
          error: '#CF6679',
          info: '#03A9F4',
          success: '#4CAF50',
          warning: '#FF9800'
        }
      }
    }
  },
  components: {
    VDateInput,
    VTimePicker
  },
})
