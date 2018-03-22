export default function (blockManager){

  blockManager.add('streaming-block', {
    label: 'Streaming',
    content: '<div name="streaming" class="blk-row streaming" style="height: 100%;width: 100%;cursor: pointer;"></div><style>.blk-row::after{content:"";clear:both;display:block;}.blk-row{padding:10px;}.blk2{float:left;width:50%;padding:10px;min-height:75px;}</style>',
    attributes: {
      class:'fa fa-video-camera',
      title: 'Insert Streaming'
    }
  });

}
