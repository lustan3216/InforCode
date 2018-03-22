export default {
  methods:{
    column_render: function(source, column){
      let self = this
      let value = source[column]

      let filter = {
        ads(value){
          return self.display_model(value, column) },
        arrive_url(value){
          return self.display_model(value, column) },
        all_ads_by_mode(value){
          return self.display_model(value, column) }
      }

      return filter[column] ? filter[column](value) : value
    },
    display_model(value, column){
      if (value){
        return '<button type="button" class="display_modal_button btn btn-xs btn-default" ' +
          'data-column="' + column + '"' +
          'data-info="'+ value +'"> SHOW </button>'
      }
    }
  }
}