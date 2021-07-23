<template>
    <div>
        <h1>This is the login page</h1>

        <input name="email" type="email" v-model="email" placeholder="Email" />
        <input name="password" type="password" v-model="password" placeholder="Password" />
        <button type="button" v-on:click="onSubmit(email, password)">Login</button>
    </div>
</template>


<script>
import { mapState } from "vuex";
import { LOGIN } from "@/store/actions.type";
export default {
    name: "Login",
    data() {
        return {
            email: null,
            password: null
        };
    },
    methods: {
        onSubmit(email, password) {
            this.$store
                .dispatch(LOGIN, { email, password })
                .then(() => this.$router.push({ name: "home" }));
        }
    },
    computed: {
        ...mapState({
            errors: state => state.auth.errors
        })
    }
};
</script>
