import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'

Vue.use(VueRouter)

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/about',
        name: 'About',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
    },
    {
        path: '/first',
        name: 'First',
        component: () => import('../views/First.vue')
    },
    {
        path: '/vote',
        name: 'Vote',
        component: () => import('../views/Vote.vue')
    },
    {
        path: '/login',
        name: 'Login',
        component: () => import('../views/Login.vue')
    },
    {
        path: '/register',
        name: 'Register',
        component: () => import('../views/Register.vue')
    },
    {
        path: '/sign_up',
        name: 'Sign_up',
        component: () => import('../views/Sign_up.vue')
    },
    {
        path: '/overview',
        name: 'Overview',
        component: () => import('../views/Overview.vue')
    },
    {
        path: '/upload',
        name: 'upload',
        component: () => import('../views/Upload.vue')
    }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
