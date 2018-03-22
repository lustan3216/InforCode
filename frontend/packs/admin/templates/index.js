import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'templates',
    columns: ['id', 'client','title', 'description', 'photo_url'],
    filter_list: [],
    sorting_list: ['id'],
    action_list: ['copy', 'edit', 'delete'],
    search_placeholder: ['id', 'name'],
    ajax_url: ''
  },
});
