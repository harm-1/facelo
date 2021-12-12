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
                        v-model="form.sexual_preference"
                        :options="gender_options"
                        required
                    ></b-form-select>
                </b-form-group>

                <b-form-group id="input-group-5" label="Birth day:" label-for="input-5">
                  <datepicker
                    v-model="form.birth_day"
                    :minimumView="day"
                  />
                </b-form-group>

                <b-form-group id="input-group-6" v-slot="{ ariaDescribedby }">
                    <b-form-checkbox-group
                        id="checkboxes-6"
                        :aria-describedby="ariaDescribedby"
                    >
                        <b-form-checkbox :value="form.terms_accepted">I accept the terms</b-form-checkbox>
                    </b-form-checkbox-group>
                </b-form-group>

                <!-- TODO style -->
                <!-- <ul v-if="errors" class="error-messages">
                     <li v-for="(v, k) in errors" :key="k">{{ k }} {{ v | error }}</li>
                     </ul>
                -->
                <b-button type="submit" variant="primary">Submit</b-button>
            </b-form>
        </b-container>
    </div>
</template>

<script>
import { mapState } from 'vuex'
import { ref } from 'vue'
import Datepicker from 'vue3-datepicker'

export default {
  name: 'Register',
  components: {
    Datepicker
  },
  data () {
    return {
      gender_options: [
        { value: 0, text: 'Please select an option' },
        { value: 1, text: 'Male' },
        { value: 2, text: 'Female' },
        { value: 3, text: 'Other' }
      ],
      now: new Date(),
      show: true,
      form: {
        email: 'foo@bar.com',
        password: 'foobar',
        gender: 1,
        sexual_preference: 2,
        birth_day: new Date(1995, 11, 17),
        terms_accepted: true
      }
    }
  },
  computed: {
    ...mapState({
      errors: state => state.auth.errors
    })
  },
  methods: {
    onSubmit () {
      console.log(this.form)
      this.form.birth_day = this.form.birth_day.toISOString().split('T')[0]
      console.log(this.form)
      this.axios.post('http://127.0.0.1:5000/user', this.form
      ).then((response) => {
        console.log(response.data)
      })
    }
  }
}
</script>
