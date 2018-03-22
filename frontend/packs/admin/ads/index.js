import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'ads',
    columns: ['id', 'default', 'client', 'name', 'status', 'manager', 'material', 'ad_template', 'daily_budget', 'daily_cost', 'clicks', 'impressions', 'faces', 'cost', 'last_time_of_calculated_at:last_calculated_time', 'deleted_at:deleted_time'],
    filter_list: [],
    sorting_list: ['id','clicks', 'impressions', 'faces', 'cost'],
    action_list: ['edit', 'delete', 'pause', 'resume'],
    search_placeholder: ['id', 'name', 'status'],
    ajax_url: ''
  },
});
