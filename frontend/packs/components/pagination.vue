<template>
  <div class="dataTables_paginate paging_bootstrap_full_number">
    <ul class="pagination">
      <li class="paginate_button previous" v-if="!isFirst()">
        <a href="javascript:;" v-on:click.prevent="firstPage()">&laquo;</a>
      </li>
      <li class="paginate_button" v-if="!isFirst()">
        <a href="javascript:;" v-on:click.prevent="prevPage()">&lsaquo;</a>
      </li>
      <template v-for="page of pages">
        <li v-if="isCurrent(page)" class="active">
          <a href="javascript:;">{{page}}</a>
        </li>
        <li v-else>
          <a href="javascript:;" v-on:click.prevent="goPage(page)">{{page}}</a>
        </li>
      </template>
      <li class="paginate_button next" v-if="!isLast()">
        <a href="javascript:;" v-on:click.prevent="nextPage()">&rsaquo;</a>
      </li>
      <li class="paginate_button next" v-if="!isLast()">
        <a href="javascript:;" v-on:click.prevent="lastPage()">&raquo;</a>
      </li>
    </ul>
  </div>
</template>


<script>
  import { pagination } from '../shared/event_hub';
  
  export default {
    template: '',
    props: {
      pagination: {
        type: Object,
        default: function() {
          return {
            next_page: '',
            prev_page: '',
            current_page: 1,
            total_pages: 1,
          }
        }
      },
    },
    data: function() {
      return {
        pages: []
      }
    },
    created: function() {
    },
    mounted: function() {
      this.calculate();
    },
    methods: {
      isFirst: function() {
        return this.pagination.current_page === 1;
      },
      isLast: function() {
        return this.pagination.current_page === this.pagination.total_pages;
      },
      isCurrent: function(page) {
        return this.pagination.current_page === page;
      },
      firstPage: function() {
        this.goPage(1);
      },
      prevPage: function() {
        var prev_page = this.pagination.current_page - 1;
        this.goPage(prev_page);
      },
      goPage: function(page) {
        pagination.$emit('go-page', page);
      },
      nextPage: function() {
        var next_page = this.pagination.current_page + 1;
        this.goPage(next_page);
      },
      lastPage: function() {
        this.goPage(this.pagination.total_pages);
      },
      calculate: function() {
        var current_page = this.pagination.current_page;
        var total_pages = this.pagination.total_pages;
        var min_page = 1;
        var max_page = total_pages;
        var page_window = 4;
        if ((current_page - page_window) > 1) {
          min_page = current_page - page_window;
        }

        if ((current_page + page_window) < total_pages) {
          max_page =  current_page + page_window;
        }
        this.pages = _.range(min_page, max_page + 1);
      },
    },
    watch: {
      pagination: function (newPagination) {
        this.calculate();
      }
    }
  };
</script>

<style scoped>

</style>