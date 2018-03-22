import adUnit       from './blocks/ad_unit'
import streaming    from './blocks/streaming'
import displayBlock from './blocks/display_block'

export default function (editor){
  let blockManager = editor.BlockManager;

  adUnit(blockManager);
  streaming(blockManager);
  displayBlock(blockManager);

  let templates = $('#gjs').data('templates')
  $.each(templates, function(i, item){
    blockManager.add('template-block', {
      label: item.title,
      content: item.content,
      attributes: {
        class:'gjs-fonts gjs-block gjs-f-b1 template',
        title: item.title
      }
    });
  })
}
