export default function (blockManager){

  blockManager.add('ad-unit', {
    label: 'Ad Unit',
    content: '<div name="ad_unit" class="blk-row ad_unit background_img"><div class="qrcode"></div></div>' +
    '<style>.ad_unit{position: relative;}.background_img{cursor: pointer;width:100%;height:100%;-webkit-background-size:cover;background-size:cover;background-position: center;background-repeat:no-repeat;}' +
    'video{z-index: 10;position: absolute;left: 0;top: 0;bottom: 0;right: 0;display: block;}' +
    '[name="ad_unit"] .qrcode{right: 10px;left: 10px;bottom: 10px;top: 10px;height: auto;z-index: 20;display: none;background-color: rgba(0,0,0,0.5);position: absolute;}' +
    '.qrcode canvas{padding: 1px;background-color: white;position: absolute;left: 50%;top: 50%;-webkit-transform:translate(-50%,-50%);-moz-transform:translate(-50%,-50%);-ms-transform:translate(-50%,-50%);-o-transform:translate(-50%,-50%);transform:translate(-50%,-50%);}' +
    '.blk-row::after{content:"";clear:both;display:block;}.blk-row{padding:10px;}.blk2{float:left;width:50%;padding:10px;min-height:75px;}</style>',
    attributes: {
      class:'fa fa-address-card-o',
      title: 'Insert ad unit'
    }
  });

}
