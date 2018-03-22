<template>
  <div class="modal fade in" id="resume_modal" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
          <h4 class="modal-title">Resume</h4>
        </div>
        <div class="modal-body"> Are sure want to resume </div>
        <div class="modal-footer">
          <button type="button" class="btn dark btn-outline" data-dismiss="modal">Close</button>
          <button type="button" class="btn green" @click="resumeSources(action_id)">Resume</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import noticeMixin from '../mixins/notice'
  
  export default {
    props: ['action_id'],
    mixins: [noticeMixin],
    methods: {
      saveCurrentPage(page){
        this.current_page = page
      },
      resumeSources (ids) {
        let self = this;
        $('.modal').modal('hide');

        $.ajax({
          url: (self.ajax_url || document.URL) + '/' + ids.toString() + '/resume',
          type: 'POST',
          dataType: 'json',
          data: { page: self.$parent.$parent.pagination.current_page }
        })
          .done(function(data, textStatus, jqXHR){
            $('.mt-checkbox input').prop('checked', false)
            self.$parent.$parent.sources = data.data;
            if (data.message.length){
              self.success_notice(data.message)
            }
          })
      }
    }
  }
</script>

<style scoped>

</style>