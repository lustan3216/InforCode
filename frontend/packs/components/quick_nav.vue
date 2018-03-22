<template>
  <div>
    <nav class="quick-nav hidden">
      <a class="quick-nav-trigger" href="#0">
        <span aria-hidden="true"></span>
      </a>
      <ul>
        <li v-if="action_list.includes('delete')">
          <a @click="delete_modal">
            <span>Delete All</span>
            <i class="fa fa-trash-o" aria-hidden="true"></i>
          </a>
        </li>
        <li v-if="action_list.includes('publish')">
          <a @click="publish_modal">
            <span>Publish All</span>
            <i class="fa fa-paper-plane-o" aria-hidden="true"></i>
          </a>
        </li>
        <li v-if="action_list.includes('pause')">
          <a @click="pause_modal">
            <span>Pause All</span>
            <i aria-hidden="true" class="fa fa-pause"></i>
          </a>
        </li>
        <li v-if="action_list.includes('resume')">
          <a @click="resume_modal">
            <span>Resume All</span>
            <i aria-hidden="true" class="fa fa-play"></i>
          </a>
        </li>
        <li v-if="action_list.includes('copy')">
          <a @click="copy_modal">
            <span>Copy All</span>
            <i aria-hidden="true" class="fa fa-files-o"></i>
          </a>
        </li>
      </ul>
      <span aria-hidden="true" class="quick-nav-bg"></span>
    </nav>
    <div class="quick-nav-overlay"></div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        action_id: ''
      }
    },
    props: ['action_list'],
    methods:{
      emit_ids(){
        this.$emit('action_ids', _.map($('tbody .mt-checkbox input:checked'), 'id').toString());
      },
      delete_modal(){
        this.emit_ids();
        $('#delete_modal').modal();
      },
      copy_modal(){
        this.emit_ids();
        $('#copy_modal').modal();
      },
      publish_modal(){
        this.emit_ids();
        $('#publish_modal').modal();
      },
      pause_modal(){
        this.emit_ids();
        $('#pause_modal').modal();
      },
      resume_modal(){
        this.emit_ids();
        $('#resume_modal').modal();
      }
    }
  }
</script>