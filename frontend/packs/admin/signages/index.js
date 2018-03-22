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
    source_name: 'signages',
    columns: ['id', 'client', 'title', 'sn', 'shop', 'container', 'token'],
    filter_list: [],
    sorting_list: ['id'],
    action_list: ['delete', 'edit', 'publish'],
    search_placeholder: ['id', 'sn', 'title', 'number', 'token'],
    ajax_url: ''
  }
});