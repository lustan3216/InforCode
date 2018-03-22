<template>
  <div class="excel_uploader">
    <form mutipart="true" id="excel_uploader" enctype="multipart/form-data" accept-charset="UTF-8">
      <input name="utf8" type="hidden" value="✓">
      <input type="hidden" name="authenticity_token" :value="get_csrf_token()">
      
      <div class="form-body">
        <div class="form-group">
          <input class="form-control hidden" :name="source_name + '[file]'" :id="source_name + '_file'" type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
          <label :for="source_name + '_file'">
            <p class="btn btn-default btn-sm">
              <span class="upload_button"><i class="fa fa-upload"></i> Click me to upload Excel</span>
              <loading-animate></loading-animate>
            </p>
          </label>
        </div>
      </div>
    </form>
    <a :href="sample_url()" class="btn btn-default btn-sm">Excel Sample</a>
    
    <div class="modal fade in" id="excel_upload_modal" tabindex="-1" role="basic" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
            <h4 class="modal-title">Publish</h4>
          </div>
          <div class="modal-body">
            <p>Are sure want to upload?</p>
            <p>File name : <span id="file_name"></span></p>
            <p>File size : <span id="file_size"></span></p>
            <p class="red text-center"><b>Need to wait for a wile after import excel file. </b></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn dark btn-outline" data-dismiss="modal">Close</button>
            <button type="button" class="btn green" @click="saveFile()">Upload</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import LoadingAnimate from './loading_animate.vue';
  import noticeMixin from '../mixins/notice'
  
  export default{
    props: ['source_name'],
    components: {LoadingAnimate},
    mixins: [noticeMixin],
    created(){
      let self = this
      
      $(document).on('change', 'input[type="file"]' , function(e){
        let file = e.target.files[0]
        
        $('#excel_upload_modal').modal('show');
        $('#file_name').html(file.name);
        $('#file_size').html(self.file_size(file))
      });
      
      $(document).on('hidden.bs.modal','#excel_upload_modal', function () {
        $('input[type="file"]')[0].value = ''
      })
    },
    methods: {
      sample_url(){
        return window.location.origin + '/excel_sample/'+ this.source_name
      },
      get_csrf_token() {
        return $('meta[name="csrf-token"]').attr('content')
      },
      saveFile(){
        let self = this;
        let ajax_url = window.location.href + '/excel_upload'
        let formData = new FormData();
        formData.append(this.source_name + '[file]',$('input[type=file]')[0].files[0])
        $.ajax({
          type: "POST",
          url: ajax_url,
          contentType: false,
          processData: false,
          data: formData,
          beforeSend(){
            $('.upload_button, #fountainG').toggleClass('hidden')
          },
          success(data) {
            self.success_notice(data.message)
          },
          error(data){
            self.error_notice(data.message)
          },
          complete(){
            $('.upload_button, #fountainG').toggleClass('hidden')
          }
        });
        
        $('#excel_upload_modal').modal('hide')
      },
      file_size(file){
        let file_size = file.size/1024;
        if (file_size > 1024){
          return file_size = (file_size/1024).toFixed(2)+' MB'
        }else{
          return file_size = file_size.toFixed(2)+' KB'
        }
      }
    }
  }
</script>

<style scoped>
  .btn-default{
    margin-left: 5px;
    margin-right: 5px;
  }
  form{
    display: inline-block;
    margin-left: 10px;
  }
  .excel_uploader{
    display: inline-block;
  }
  .red{
    color: red;
  }
</style>