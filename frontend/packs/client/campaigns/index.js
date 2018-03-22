import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'campaigns',
    columns: ['id','name',  'manager', 'ads', 'daily_budget', 'clicks', 'impressions', 'faces', 'cost', 'deleted_at:deleted_time'],
    filter_list: [],
    sorting_list: ['id','clicks', 'impressions', 'faces', 'cost'],
    action_list: ['edit', 'delete', 'pause', 'resume'],
    search_placeholder: ['id', 'name'],
    ajax_url: ''
  },
});
