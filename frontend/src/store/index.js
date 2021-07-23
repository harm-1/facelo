import Vue from 'vue'
import Vuex from 'vuex'

import test from "./test.module"
import auth from "./auth.module"

Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        test,
        auth
    }
})
