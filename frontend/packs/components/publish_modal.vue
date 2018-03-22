<template>
  <div class="modal fade in" id="publish_modal" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
          <h4 class="modal-title">Publish</h4>
        </div>
        <div class="modal-body"> Are sure want to publish </div>
        <div class="modal-footer">
          <button type="button" class="btn dark btn-outline" data-dismiss="modal">Close</button>
          <button type="button" class="btn green" @click="publishSources(action_id)">Publish</button>
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
    data() {
      return {
        current_page: 1
      }
    },
    methods: {
      publishSources (ids) {
        let self = this;
        $('.modal').modal('hide');

        $.ajax({
          url: (self.ajax_url || document.URL) + '/' + ids.toString() + '/publish',
          type: 'POST',
          dataType: 'json'
        }).done(function(data, textStatus, jqXHR){
            $('.mt-checkbox input').prop('checked', false)
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