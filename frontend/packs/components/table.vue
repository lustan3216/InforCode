<template>
  <div class="table-responsive">
    <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer">
      <thead>
      <tr role="row" class="heading">
        <td>
          <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
            <input type="checkbox" class="checkboxes" value="1"><span></span>
          </label>
        </td>
        <th v-for="column in original_columns"
            :name="column"
            :class="[sorting_list.includes(column) ? 'sorting' : '']">{{ column_name(column) | to_title }}
        </th>
        <th v-if="show_action">Actions</th>
      </tr>
      <tr role="row" class="filter" v-if="filter_list.length > 0">
        <td></td>
        <td v-for="column in original_columns">
          <input type="text" class="form-control form-filter input-sm" :id="column" :key="column" v-if="filter_list.includes(column)">
        </td>
        <td></td>
      </tr>
      </thead>
      
      <tbody>
      <tr class="gradeX" v-for="(source, source_index) in sources" :key="source_index" >
        <td>
          <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
            <input :id="source.id" type="checkbox" class="checkboxes" value="1"><span></span>
          </label>
        </td>
        <td v-for="column in original_columns" :name="column+'_'+source['id']" v-html="column_render(source, column)"></td>
        <td v-if="show_action">
          <div class="btn-group">
            <button class="btn btn-xs green dropdown-toggle" type="button" data-toggle="dropdown">
              Actions <i class="fa fa-angle-down"></i>
            </button>
            <ul class="dropdown-menu" role="menu">
              <li v-if="customized_action_list.show">
                <a :href="source_name + '/' + source.id"><i class="fa fa-eye"></i> {{customized_action_list.show}} </a>
              </li>
              <li v-if="customized_action_list.edit">
                <a :href="source_name + '/' + source.id + '/edit'"><i class="fa fa-pencil-square-o"></i> {{customized_action_list.edit}} </a>
              </li>
              <li v-if="customized_action_list.delete">
                <a :id="source.id" @click="delete_modal(source.id)"><i class="fa fa-trash" aria-hidden="true"></i> {{customized_action_list.delete}} </a>
              </li>
              <li v-if="customized_action_list.publish">
                <a :id="source.id" @click="publish_modal(source.id)"><i class="fa fa-paper-plane" aria-hidden="true"></i> {{customized_action_list.publish}} </a>
              </li>
              <li v-if="customized_action_list.pause">
                <a :id="source.id" @click="pause_modal(source.id)"><i class="fa fa-pause" aria-hidden="true"></i> {{customized_action_list.pause}} </a>
              </li>
              <li v-if="customized_action_list.resume">
                <a :id="source.id" @click="resume_modal(source.id)"><i class="fa fa-play" aria-hidden="true"></i> {{customized_action_list.resume}} </a>
              </li>
              <li v-if="customized_action_list.copy">
                <a :id="source.id" @click="copy_modal(source.id)"><i class="fa fa-play" aria-hidden="true"></i> {{customized_action_list.copy}} </a>
              </li>
            </ul>
          </div>
        </td>
      </tr>
      </tbody>
    </table>
    
    <display-modal :element="element"></display-modal>
    <pause-modal :action_id="action_id"></pause-modal>
    <resume-modal :action_id="action_id"></resume-modal>
    <delete-modal :action_id="action_id"></delete-modal>
    <publish-modal :action_id="action_id"></publish-modal>
    <copy-modal :action_id="action_id"></copy-modal>
    <quick-nav @action_ids="action_id = $event" :action_list="action_list"></quick-nav>
  </div>
</template>

<script>
  import DeleteModal    from './delete_modal.vue'
  import PublishModal   from './publish_modal.vue'
  import PauseModal     from './pause_modal.vue'
  import ResumeModal    from './resume_modal.vue'
  import DisplayModal   from '../components/display_modal.vue'
  import CopyModal      from '../components/copy_modal.vue'
  import QuickNav       from '../components/quick_nav.vue';
  import Sorting        from '../mixins/sorting';
  import columnsRender  from '../mixins/columns_render';

  export default {
    components: {
      DeleteModal, PublishModal, QuickNav, ResumeModal, PauseModal, DisplayModal, CopyModal
    },
    mixins:[Sorting, columnsRender],
    props: ['source_name','sources', 'columns', 'sorting_list', 'filter_list', 'action_list'],
    data() {
      return {
        action_id: '',
        element: '',
        original_columns: [],
        customized_action_list:{
          show: '',
          edit: '',
          delete: '',
          publish: '',
          pause: '',
          resume: ''
        }
      }
    },
    mounted(){
      let self = this;
      $(document).on('click','.display_modal_button',function(e){
        self.display_modal(e)
      });
    },
    created(){
      let self = this;
      self.customize_action_name()
      this.original_columns = this.columns.map(e => e.split(':')[0])
    },
    computed:{
      show_action(){
        return this.action_list.length > 0
      }
    },
    methods: {
      customize_action_name(){
        let self = this;
        self.action_list.forEach((action) => {
          let arr = action.split(':');
          let original_name = arr[0];
          let edited_name = arr[1];
          name = edited_name ? edited_name : original_name;
          self.customized_action_list[original_name] = _.capitalize(name)
        });
      },
      column_name(column){
        const orignal_name = this.columns.find(e => e.split(':')[0] === column)
        let name = orignal_name.split(':')
        return name[1] ? name[1] : name[0]
      },
      delete_modal(id){
        this.action_id = id;
        $('#delete_modal').modal()
      },
      copy_modal(id){
        this.action_id = id;
        $('#copy_modal').modal()
      },
      publish_modal(id){
        this.action_id = id;
        $('#publish_modal').modal()
      },
      pause_modal(id){
        this.action_id = id;
        $('#pause_modal').modal()
      },
      resume_modal(id){
        this.action_id = id;
        $('#resume_modal').modal()
      },
      display_modal(element){
        this.element = element;
        $('#display_modal').modal()
      }
    }
  }
</script>