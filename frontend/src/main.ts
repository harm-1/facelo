import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axios from 'axios'
import VueAxios from 'vue-axios'
import BootstrapVue3 from 'bootstrap-vue-3'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue-3/dist/bootstrap-vue-3.css'

// import ApiService from "./common/api.service";
// createApp(App).use(store).use(router).mount('#app')

const app = createApp(App)
app.use(router)
app.use(store)
app.use(VueAxios, axios)
app.use(BootstrapVue3)
// ApiService.init();

app.mount('#app')
