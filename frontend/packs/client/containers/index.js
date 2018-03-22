import Vue       from 'vue/dist/vue.esm';
import mainMixin from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'containers',
    columns: ['id', 'title', 'description'],
    filter_list: [],
    sorting_list: ['id'],
    action_list: ['delete', 'edit', 'show:template', 'publish'],
    search_placeholder: ['id', 'title', 'description'],
    ajax_url: ''
  },
});
