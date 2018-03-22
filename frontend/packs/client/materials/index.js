import Vue             from 'vue/dist/vue.esm';
import mainMixin       from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'materials',
    columns: ['id', 'name', 'manager', 'ads', 'ads_count', 'ad_template', 'trigger_file', 'display_file', 'arrive_url'],
    filter_list: [],
    sorting_list: ['id','height', 'width'],
    action_list: ['edit', 'delete'],
    search_placeholder: ['id', 'name'],
    ajax_url: ''
  }
});
