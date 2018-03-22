import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'ad_templates',
    columns: ['id','title', 'description', 'width', 'height'],
    filter_list: [],
    sorting_list: ['id','width', 'height'],
    action_list: ['edit', 'delete'],
    search_placeholder: ['id', 'title', 'description'],
    ajax_url: ''
  },
});
