<template>

    <!-- v-bind:title="test_type" --> 
    <div>
        <b-card
            v-bind:img-src="img_src"
            img-alt="http://placehold.jp/80x80.png"
            img-top
            tag="article"
            style="width: 15rem;"
            class="mb-2"
        >
            <b-card-text>
                {{ test_type }} {{score}}
            </b-card-text>
        </b-card>
    </div>
</template>

<script>
export default {
    name: "ResultCard",
    props: {
        img_src: {
            type: String,
            required: true
        },
        score: {
            type: Number,
            required: true
        },
        test_type: {
            type: String,
            required: true
        }
    }
}
</script>
