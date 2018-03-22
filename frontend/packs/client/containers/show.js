import Vue                from 'vue/dist/vue.esm';
import htmlSaveMixin      from '../../grape/html_save/main';
import grapesInitMixin    from '../../grape/init';

import  './show.css';

let gjs_vue = new Vue({
  el: '#app',
  mixins: [htmlSaveMixin, grapesInitMixin],
  mounted() {
    this.grapesInit()
  },
  methods: {
    get_image(assetManager){
      $.ajax({
        url: window.location.href + '/image',
        dataType: 'json'
      }).done(data => assetManager.add(data.data))
    },
    delete_image(src){
      $.ajax({
        url: window.location.href + '/image',
        type: 'DELETE',
        dataType: 'json',
        data: {src: src}
      })
    },
    set_gjs_html(html){
      localStorage[this.gjs_id() + '-html'] = html
    },
    set_gjs_css(css){
      localStorage[this.gjs_id() + '-css'] = css
    },
    gjs_id(){
      return ('gjs-' + $('#gjs').data('id'))
    }
  }
});
window.gjs_vue = gjs_vue;

