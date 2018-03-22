import                     '../shared/filter.js';
import _              from 'lodash';
import TableVue       from '../components/table.vue';
import PaginationVue  from '../components/pagination.vue';
import { pagination } from '../shared/event_hub';

export default {
  components: {
    PaginationVue, TableVue
  },
  data: {
    sources: [],
    find_text: '',
    pagination: {
      next_page: '',
      prev_page: '',
      current_page: 1,
      total_pages: 1,
    }
  },
  created () {
    pagination.$on('go-page', this.goPage);
  },
  beforeDestroy () {
    pagination.$off('go-page', this.goPage);
  },
  mounted () {
    this.fetchSources();
  },
  methods: {
    fetchSources (arg, search_keyword, sorting={}) {
      let self = this;
      let page = (typeof arg === 'undefined') ? this.pagination.current_page : arg;
      let data = { page: page, q: search_keyword, sorting_name: sorting['name'], sorting_taxis: sorting['taxis'] };

      $.ajax({
        url: self.ajax_url || document.URL,
        method: 'GET',
        dataType: 'json',
        data: data,
      }).done(function(data, textStatus, jqXHR){
        self.sources = data.data;
        self.pagination = data.pagination;
      })
    },
    goPage (page) {
      this.fetchSources(page);
    }
  },
  watch: {
    find_text: _.debounce(function (val) {
      this.fetchSources (this.pagination.current_page, val)
    }, 500)
  }
}

$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});