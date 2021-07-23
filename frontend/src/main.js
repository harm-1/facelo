import '@babel/polyfill'
import 'mutationobserver-shim'
import Vue from 'vue';
import './plugins/bootstrap-vue'
import './plugins/vuelidate'
import App from './App.vue';
import router from './router';
import store from './store';

import ApiService from "./common/api.service";
import './assets/global.css'

Vue.config.productionTip = false;

ApiService.init();

new Vue({
    store, 
    router,
    render: h => h(App)
}).$mount('#app');
