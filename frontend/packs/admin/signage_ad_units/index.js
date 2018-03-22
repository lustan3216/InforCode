import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'signage_ad_units',
    columns: ['id', 'client', 'ad_template', 'all_ads_by_mode', 'title', 'mode'],
    filter_list: [],
    sorting_list: ['id'],
    action_list: ['edit', 'delete', 'resume', 'pause'],
    search_placeholder: ['id', 'name', 'status'],
    ajax_url: ''
  },
});
