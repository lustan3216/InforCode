import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'users',
    columns: ['id', 'client', 'email', 'name'],
    filter_list: [],
    sorting_list: ['id','client'],
    action_list: ['edit', 'delete', 'pause', 'resume'],
    search_placeholder: ['id', 'name', 'email'],
    ajax_url: ''
  },
});
