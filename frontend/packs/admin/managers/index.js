import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'managers',
    columns: ['id', 'client', 'name', 'status', 'email', 'daily_budget', 'remaining_sum', 'ads_count', 'eligible_ads_count', 'last_time_of_calculated_at:last_calculated_time'],
    filter_list: [],
    sorting_list: ['id','daily_budget', 'remaining_sum', 'ads_count', 'eligible_ads_count'],
    action_list: ['show:transaction history', 'edit', 'delete', 'pause', 'resume'],
    search_placeholder: ['id', 'email'],
    ajax_url: ''
  },
});
