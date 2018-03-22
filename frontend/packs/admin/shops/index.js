import Vue            from 'vue/dist/vue.esm';
import mainMixin      from '../../mixins/main';
import ExcelUpload    from '../../components/excel_upload.vue';

new Vue({
  el: '#app',
  mixins: [mainMixin],
  components: {
    ExcelUpload
  },
  data: {
    source_name: 'shops',
    columns: ['id', 'client', 'title', 'description','address', 'telephone', 'signage_counts'],
    filter_list: [],
    sorting_list: ['id','signages_count'],
    action_list: ['delete', 'edit', 'publish'],
    search_placeholder: ['id', 'title', 'description', 'country', 'zipcode', 'city', 'district', 'address1', 'telephone'],
    ajax_url: ''
  },
});
