
<template>
    <div>
        <h1>This is the first page</h1>
        <p> {{ count }} </p>
        <button @click="increment">increment</button>
        <p id="display">Display some text</p>
    </div>
</template>

<script>

export default {
    name: 'First',
    computed: {
        count() {
            return this.$store.getters.count
        },
    },
    methods: {
        increment() {
            this.$store.commit('increment')
            console.log(this.$store.state.count)
        }
    },
}
</script>
