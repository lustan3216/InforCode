namespace :real do

  task build: %i[ad_template template]

  task ad_template: :environment do
    puts('create ad template')

    AdTemplate.create(width: 1280, height: 736, client_id: Client.ids.last, title: '1280 * 736')
    AdTemplate.create(width: 640, height: 368, client_id: Client.ids.last, title: '640 * 368')
    AdTemplate.create(width: 426, height: 245, client_id: Client.ids.last, title: '426 * 245')
    AdTemplate.create(width: 854, height: 490, client_id: Client.ids.last, title: '854 * 490')

    p AdTemplate.all.size
  end

  task template: :environment do
    puts('create template')

    Template.create(title: '1Bock', client_id: Client.ids.last, content:'<div name="1Block" class="one-block"></div><style>.one-block{width:100vw;height:100vh;}[name="ad_unit"] .qrcode{display:none;height:100%;background-color:rgba(0, 0, 0, 0.5);position:relative;}.qrcode canvas{padding-top:1px;padding-right:1px;padding-bottom:1px;padding-left:1px;background-color:white;position:absolute;left:50%;top:50%;transform:translate(-50%, -50%);}.blk-row::after{content:"";clear:both;display:block;}.blk-row{padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:10px;padding:0px 0px 0px 0px;}</style>')
    Template.create(title: '4Block', client_id: Client.ids.last, content:'<div name="4Block" class="blk-row-four four-block no-padding"><div class="blk-row-four no-padding"><div class="four-blk2 one_of_four_block"></div><div class="four-blk2 one_of_four_block"></div></div><div class="blk-row-four no-padding"><div class="four-blk2 one_of_four_block"></div><div class="four-blk2 one_of_four_block"></div></div></div> <style>[name="ad_unit"] .qrcode{display:none;height:100%;background-color:rgba(0, 0, 0, 0.5);position:relative;}.qrcode canvas{padding-top:1px;padding-right:1px;padding-bottom:1px;padding-left:1px;background-color:white;position:absolute;left:50%;top:50%;transform:translate(-50%, -50%);}.blk-row-four::after{content:"";clear:both;display:block;}.blk-row-four{padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:10px;width:auto;}.blk-row-four.ad_unit.background_img{width:auto;}.blk-row-four.no-padding{padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;width:100%;height:50%;}.four-block{width:1280px;height:768px;}.four-blk2{float:left;width:50%;min-height:75px;padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;height:50px;}.blk-row-four.four-block{padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;}.four-blk2.one_of_four_block{height:100%;width:50%;}.blk-row-four.four-block.no-padding{width:100vw;height:100vh;}</style>')
    Template.create(title: '6Block', client_id: Client.ids.last, content:'<div class="blk-row six_block no-padding" name="6B-template"><div class="blk-row no-padding six-top"><div class="six-blk2"></div><div class="six-blk2 no-padding"><div class="six-blk1 no-padding"></div><div class="six-blk1"></div></div></div><div class="blk-row no-padding six-down"><div class="six-blk3"></div><div class="six-blk3"></div><div class="six-blk3"></div></div></div><style>[name="ad_unit"] .qrcode{display:none;height:100%;background-color:rgba(0, 0, 0, 0.5);position:relative;}.qrcode canvas{padding-top:1px;padding-right:1px;padding-bottom:1px;padding-left:1px;background-color:white;position:absolute;left:50%;top:50%;transform:translate(-50%, -50%);}.blk-row::after{content:"";clear:both;display:block;}.blk-row{padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;}.six-blk1{width:100%;min-height:75px;height:50%;padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;}.six-blk3{float:left;width:33.3333%;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:10px;min-height:75px;height:100%;padding:0px 0px 0px 0px;}.six-blk2{float:left;width:66.6%;min-height:75px;height:100%;padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;}.blk-row.six_block{width:100vw;height:100vh;}.blk-row.six_block.no-padding{padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;width:100vw;height:100vh;}.blk-row.no-padding{padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;height:auto;}.six-blk2.no-padding{padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;width:33.3%;}.blk-row.no-padding.six-top{height:66.6%;}.blk-row.no-padding.six-down{height:33.3%;}</style>')
    p Template.all.size
  end

end

