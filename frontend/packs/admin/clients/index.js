import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  data: {
    source_name: 'clients',
    columns: ['id', 'title', 'description', 'telephone', 'ad_impression_price', 'ad_click_price', 'ad_face_price', 'full_address'],
    filter_list: [],
    sorting_list: ['id', 'ad_impression_price', 'ad_click_price', 'ad_face_price'],
    action_list: ['edit', 'pause', 'resume'],
    search_placeholder: ['id', 'title', 'address1', 'telephone'],
    ajax_url: ''
  },
});
