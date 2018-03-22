<template>
  <div class="modal fade in" id="display_modal" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
          <h4 class="modal-title">{{ column | to_title }} Display</h4>
        </div>
        <div class="modal-body" v-html="display_info()">{{ display_info() }}</div>
        <div class="modal-footer">
          <button type="button" class="btn dark btn-outline" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: ['element'],
    data() {
      return {
        column: ''
      }
    },
    methods: {
      display_info(){
        let target = this.element.target
        let no_data = '<p style="color: red;"> No data</p>'
        if(!target){ return no_data}

        this.column = target.dataset.column
        let info = target.dataset.info

        if(!info){ return no_data}
        
        return info
      }
    }
  }
</script>