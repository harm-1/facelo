const state = {
    count: 0
};

const getters = {
    count: state => state.count
};

const actions = {
    // todo
};

const mutations = {
    increment (state) {
        state.count++
    }
};

export default {
    state,
    actions,
    mutations,
    getters
};
