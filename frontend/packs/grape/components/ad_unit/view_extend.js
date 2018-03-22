import { pushIdToTempShow, tempShowResetInterval } from '../reset_interval'

export default {
  show_ad: function(e) {
    if (!Array.from(e.target.classList).includes('ad_unit')) return;
    if (!_.isEmpty(Array.from($(e.target).find('.qrcode:visible')))) return;

    const displayBlock = $(e.target).parents('body').find('.display_block');
    const arriveUrl    = e.target.dataset.arriveUrl;

    this.showQrcode(e, arriveUrl);

    if (displayBlock[0]){
      const video      = displayBlock.find('video')[0];
      const triggerUrl = e.target.dataset.triggerUrl;

      this.appendTriggerSource(displayBlock, video, triggerUrl)
    }
  },


  appendTriggerSource(displayBlock, video, triggerUrl){
    if (triggerUrl.indexOf('mp4') !== -1){
      const video_code = `<div class="temp_show_ad background_img" style="position: absolute;top: 0;z-index: 10;">
                            <video poster="http://cdn.iiiiiii.com/data/transparent.png" autoplay class="gjs-no-pointer video-js vjs-default-skin" style="height: 100%; width: 100%;">
                              <source src="${triggerUrl}" type="video/mp4">
                            </video>
                          <div>`;

      tempShowResetInterval(displayBlock);

      displayBlock.find('.temp_show_ad').remove();
      displayBlock.append(video_code);
    }else{
      const tempShow = `<div class="temp_show_ad background_img" style="position: absolute;top: 0;z-index: 10;background-image:url(${triggerUrl})"><div>`;

      tempShowResetInterval(displayBlock);
      displayBlock.append(tempShow);
      video && video.pause();
    }

    pushIdToTempShow(() => {
      displayBlock.find('.temp_show_ad').animate({opacity: 0}, 1500 );
    }, 13500);

    pushIdToTempShow(() => {
      displayBlock.find('.temp_show_ad').remove();
      video && video.play();
    }, 14500);
  },


  showQrcode(e, arriveUrl){
    $(e.target).find('.qrcode')
      .show().html('')
      .qrcode(arriveUrl || 'http://www.iiiiiii.com/')
      .find('canvas')
      .height('80%');
  }
}