import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'manager_transaction_histories',
    columns: ['add_minus_money:transaction', 'remaining_sum:balance', 'created_at:created_time', 'deleted_at:deleted_time'],
    filter_list: [],
    sorting_list: [],
    action_list: [],
    search_placeholder: [],
    ajax_url: `${document.URL}/transaction_histories`
  },
});
