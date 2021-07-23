
<template>
    <div>
        <b-container>
            <b-card-group deck>
                <result-card draggable="true"
                    v-for="s_result in sample_results"
                    :key="s_result.score"
                    v-bind:img_src="s_result.img"
                    v-bind:score="s_result.score"
                    v-bind:test_type="s_result.test_type"
                ></result-card>
            </b-card-group>
        </b-container>
    </div>
</template>


<script>
import ResultCard from "@/components/ResultCard.vue";

export default {
    name: 'overview',
    components: {
        'result-card': ResultCard
    },
    data: function() {
        return {
            x: 'hello',
            sample_results: [
                {img:'http://placehold.jp/90x90.png', score: 1, test_type: 'Who do you prefer?'},
                {img:"http://placehold.jp/90x90.png", score: 2, test_type: 'Who do you prefer?'},
                {img:"http://placehold.jp/90x90.png", score: 3, test_type: 'Who do you prefer?'},
                {img:"http://placehold.jp/90x90.png", score: 4, test_type: 'Who do you prefer?'},
                {img:"http://placehold.jp/90x90.png", score: 5, test_type: 'Who do you prefer?'},
                {img:"http://placehold.jp/90x90.png", score: 6, test_type: 'Who do you prefer?'},
                {img:"http://placehold.jp/90x90.png", score: 7, test_type: 'Who do you prefer?'},
                {img:"http://placehold.jp/90x90.png", score: 8, test_type: 'Who do you prefer?'},
                {img:"http://placehold.jp/90x90.png", score: 9, test_type: 'Who do you prefer?'},
            ]
        }
    }
}

</script>
