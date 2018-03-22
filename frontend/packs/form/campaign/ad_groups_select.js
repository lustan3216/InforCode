export default {
  el: 'form',
  data: {
    manager_id: $('#campaign_manager_id').val()
  },
  mounted(){
    let self = this
    $(document).ready(()=>{
      $('#campaign_ad_group_ids').select2()
      self.fetch_ads
    })
  },
  computed:{
    fetch_ads(){
      let self = this
      $("#campaign_ad_group_ids").select2({
        ajax: {
          url: self.ajax_url,
          data() {
            return { manager_id: self.manager_id }
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
        return '/admin/form_datas/ad_groups'
      }
      return '/form_datas/ad_groups'
    }
  },
  methods:{
    cleanSelect(){
      $('#campaign_ad_group_ids option').removeAttr('selected')
      $('#campaign_ad_group_ids').parent().find('.select2-selection__choice__remove').click()
    }
  },
  watch:{
    manager_id(){
      this.fetch_ads
      this.cleanSelect()
    }
  }
}