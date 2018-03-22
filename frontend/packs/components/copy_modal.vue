<template>
  <div class="modal fade in" id="copy_modal" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
          <h4 class="modal-title">Copy</h4>
        </div>
        <div class="modal-body"> Are sure want to copy </div>
        <div class="modal-footer">
          <button type="button" class="btn dark btn-outline" data-dismiss="modal">Close</button>
          <button type="button" class="btn green" @click="copySources(action_id)">Copy</button>
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
      copySources (ids) {
        let self = this;
        $('.modal').modal('hide');

        $.ajax({
            url: `${self.ajax_url || document.URL}/${ids.toString()}/copy`,
            type: 'post',
            dataType: 'json',
            data: { page: self.$parent.$parent.pagination.current_page }
          })
          .done(function(data){
            $('.mt-checkbox input').prop('checked', false)
            self.$parent.$parent.sources = data.data;
            self.$parent.$parent.pagination = data.pagination;
            self.success_notice(data.message)
          })
          .fail(function(data){
            self.error_notice(data.message)
          });
      }
    }
  }
</script>

<style scoped>

</style>