export default function (blockManager){

  blockManager.add('display-block', {
    label: 'Trigger Block',
    content: '<div name="display_block" class="blk-row display_block" style="position: relative; width:100%; height:100%; padding: 0!important;"></div>',
    attributes: {
      class: 'fa fa-picture-o',
      title: 'Insert trigger block'
    }
  });

}
