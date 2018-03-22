<template>
  <div class="modal fade in" id="delete_modal" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
          <h4 class="modal-title">Delete</h4>
        </div>
        <div class="modal-body"> Are sure want to delete </div>
        <div class="modal-footer">
          <button type="button" class="btn dark btn-outline" data-dismiss="modal">Close</button>
          <button type="button" class="btn green" @click="deleteSources(action_id)">Delete</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import { pagination } from '../shared/event_hub';
  import noticeMixin from '../mixins/notice'
  
  export default {
    props: ['action_id'],
    mixins: [noticeMixin],
    data() {
      return {
        current_page: 1
      }
    },
    created(){
      pagination.$on('go-page', this.saveCurrentPage);
    },
    methods: {
      saveCurrentPage(page){
        this.current_page = page
      },
      deleteSources (ids) {
        let self = this;
        $('.modal').modal('hide');
        
        $.ajax({
          url: (self.ajax_url || document.URL) + '/' + ids.toString() ,
          type: 'DELETE',
          dataType: 'json',
          data: { page: self.$parent.$parent.pagination.current_page }
        })
          .done(function(data, textStatus, jqXHR){
            $('.mt-checkbox input').prop('checked', false)
            self.$parent.$parent.sources = data.data;
            self.$parent.$parent.pagination = data.pagination;
            self.success_notice(data.message)
          })
          .fail(function(data, textStatus, jqXHR){
            self.error_notice(data.message)
          });
      }
    }
  }
</script>

<style scoped>

</style>