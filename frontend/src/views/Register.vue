<template>
    <div>
        <b-container fluid style="max-width: 500px">
            <b-form @submit="onSubmit">
                <b-form-group
                    id="input-group-1"
                    label="Email address:"
                    label-for="input-1"
                >
                    <b-form-input
                        id="input-1"
                        v-model="form.email"
                        type="email"
                        placeholder="Enter email"
                        required
                    ></b-form-input>
                </b-form-group>

                <b-form-group id="input-group-2" label="Password:" label-for="input-2">
                    <b-form-input
                        id="input-2"
                        v-model="form.password"
                        placeholder="Enter password"
                        required
                    ></b-form-input>
                </b-form-group>

                <b-form-group id="input-group-3" label="Gender:" label-for="input-3">
                    <b-form-select
                        id="input-3"
                        v-model="form.gender"
                        :options="gender_options"
                        required
                    ></b-form-select>
                </b-form-group>

                <b-form-group id="input-group-4" label="Sexual preference:" label-for="input-4">
                    <b-form-select
                        id="input-4"
                        v-model="form.sexual_preferemce"
                        :options="gender_options"
                        required
                    ></b-form-select>
                </b-form-group>

                <b-form-group id="input-group-5" label="Age:" label-for="input-5">
                    <b-form-input
                        id="input-5"
                        v-model="form.age"
                        type="number"
                        placeholder="Enter age"
                        required
                    ></b-form-input>
                </b-form-group>

                <b-form-group id="input-group-6" v-slot="{ ariaDescribedby }">
                    <b-form-checkbox-group
                        v-model="form.checked"
                        id="checkboxes-6"
                        :aria-describedby="ariaDescribedby"
                    >
                        <b-form-checkbox v-model="form.terms_accepted">I accept the terms</b-form-checkbox>
                    </b-form-checkbox-group>
                </b-form-group>

                <!-- TODO style -->
                <ul v-if="errors" class="error-messages">
                    <li v-for="(v, k) in errors" :key="k">{{ k }} {{ v | error }}</li>
                </ul>

                <b-button type="submit" variant="primary">Submit</b-button>
            </b-form>
        </b-container>
    </div>
</template>

<script>
import { mapState } from "vuex";
import { REGISTER } from "@/store/actions.type";

export default {
    name: "Register",
    data() {
        return {
            gender_options: [
                {value: 0, text: 'Please select an option'},
                {value: 1, text: 'Male'},
                {value: 2, text: 'Female'},
                {value: 3, text: 'Other'}
            ],
            form: {
                email: '',
                password: '',
                gender: null,
                terms_accepted: false
            },
        }
    },
    computed: {
        ...mapState({
            errors: state => state.auth.errors
        })
    },
    methods: {
        // onSubmit(event) {
        //     event.preventDefault()
        //     alert(JSON.stringify(this.form))
        // },
        onSubmit() {
            this.$store
                .dispatch(REGISTER, this.form)
                .then(() => this.$router.push({ name: "home" }));
        }
    }
}
</script>
