import Grapes             from '../vendor/grape/grapes.min';
import tool_manager       from './tool_manager';
import blockManager       from './block_manager';
import componentManager   from './component_manager';

import '../vendor/grape/css/grapes.min.css';
import './modify.css';

export default {
  methods: {
    grapesInit(){
      this.fetch_content();
      tool_manager(Grapes);

      let editor = Grapes.init({
        container : '#gjs',
        autorender: 0,
        height: '100%',
        autosave: true,
        cache: false,
        stepsBeforeSave: 1,
        plugins: ['gjs-preset-webpage'],
        storageManager: {
          id: 'gjs-' + $('#gjs').data('id') + '-',
          autosave: true,
        },
        assetManager: {
          upload: window.location.href + '/image',
          uploadText: 'Drop files here or click to upload',
        }
      });

      let assets = editor.AssetManager.getAll();
      this.get_image(assets);
      assets.on('remove', (asset) => this.delete_image(asset.get('src')) );

      blockManager(editor);
      componentManager(editor);
      editor.Config.allowScripts = 1;
      editor.set_gjs_html = (html) => this.set_gjs_html(html);

      const styleManager = editor.StyleManager;
      styleManager.getSectors().models[1]['attributes']['properties']['models'][0]['attributes']['units'].push('vh','vw')
      styleManager.getSectors().models[1]['attributes']['properties']['models'][1]['attributes']['units'].push('vh','vw')

      editor.render();
      window.editor = editor;
    },
    fetch_content(){
      $.ajax({
        url: window.location.href + '/content',
        dataType: 'json'
      }).done(data => {
        if (data.html)
          this.set_gjs_html(data.html);
        if (data.css)
          this.set_gjs_css(data.css)
      })
    }
  }
}