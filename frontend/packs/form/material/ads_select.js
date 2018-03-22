export default {
  el: '#material_form',
  data: {
    manager_id: $('#material_manager_id').val(),
    ad_template_id: $('#material_ad_template_id').val()
  },
  mounted(){
    let self = this;
    $(document).ready(() => {
      $('#material_ad_ids').select2();
      self.fetch_ads

      $('input[type=file]').on('change', function(event) {
        $(this).siblings('img, video').hide();

        const files    = event.target.files;
        const file     = files[0];
        const reader   = new FileReader();

        if (file.name.split('.').pop() === 'mp4'){
          const video_show = $(this).siblings('video');
          reader.onload  = (file) => {
            video_show.attr('src', file.target.result);
            video_show.show();
          }
        }else {
          const img_show = $(this).siblings('img');
          reader.onload  = (file) => {
            const img = new Image();
            img_show.attr('src', file.target.result);
            img_show.show();
          };
        }

        reader.readAsDataURL(file);
      })
    })
  },
  computed:{
    fetch_ads(){
      let self = this
      $("#material_ad_ids").select2({
        ajax: {
          url: self.ajax_url,
          data() {
            return {
              manager_id: self.manager_id,
              ad_template_id: self.ad_template_id
            }
          },
          processResults(data) {
            return {results: data.map(x => ({id: x.id, text: "["+x.id+"] "+x.name}))
            };
          }
        }
      });
    },
    ajax_url(){
      if (document.URL.indexOf('admin') !== -1 ){
        return '/admin/form_datas/ads'
      }
      return '/form_datas/ads'
    }
  },
  methods:{
    cleanSelect(){
      $('#material_ad_ids option').removeAttr('selected')
      $('#material_ad_ids').parent().find('.select2-selection__choice__remove').click()
    }
  },
  watch:{
    manager_id(){
      this.fetch_ads
      this.cleanSelect()
    },
    ad_template_id(){
      this.fetch_ads
      this.cleanSelect()
    }
  }
}