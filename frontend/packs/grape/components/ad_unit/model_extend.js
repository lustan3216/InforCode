import { resetInterval } from '../reset_interval'

export default {

  ajaxAdUnit() {
    const ad_unit_id = +this.attributes.attributes['data-ad-unit-id'];
    if (ad_unit_id){
      $.ajax({
        url: `/api/v1/signage_ad_units/${ad_unit_id}?for_grapejs=true`
      }).done((data) => {
        if (data.mode === 'random' && data.data){
          this.playRandomAd(data)

        }else if (data.mode === 'specific' && data.data.length > 0){
          this.dealScriptAds(data)

        }else{
          $.bootstrapGrowl('This AdUnit has no data!', {type: 'danger', align: 'right', offset: {from: 'bottom', amount: 30}});
        }
      })
    }
  },


  dealScriptAds(data){
    // 處理script的ad且playScriptAd，並把資料存在logstash之後每固定時間才會拉一次資料 預設4小時，
    const unit_id  = data.signage_ad_unit_id;
    const interval = data.refresh_script_hour * 60*60*1000 || 60*60*1000*4;
    const refresh_ad_second = data.refresh_ad_second * 1000 || 15000;
    const action   = () => this.ajaxAdUnit(this);

    localStorage[unit_id + '_ad_script'] = JSON.stringify({
      refresh_ad_second: refresh_ad_second,
      ads: data.data
    });

    resetInterval(this.cid + 'script_refresh', action, interval);
    this.playScriptAd(unit_id, 0);
  },


  playScriptAd(unit_id, _ad_index){
    // 根據ads 的array依照index 每次都＋1 一直照順序輪播

    const interval    = localStorage[unit_id + '_ad_script'].refresh_ad_second * 1000 || 15000;
    const ads         = JSON.parse(localStorage[unit_id + '_ad_script']).ads;
    const ad_index    = ((_ad_index + 1) % ads.length) - 1;
    const ad          = ad_index === -1 ? ads.slice(-1)[0] : ads[ad_index];
    const material    = ad.material[0];
    const display_url = material.display_file.url;

    const action = () => this.playScriptAd(unit_id, ad_index+1);

    this.appendDisplaySource(this.view.el, display_url);
    this.appendDataToElement(ad.id, material);
    resetInterval(this.cid + 'ad_refresh', action, interval);
  },


  playRandomAd(data){
    const ad          = data.data;
    const material    = ad.material[0];
    const interval    = data.refresh_ad_second * 1000 || 15000;
    const display_url = material.display_file.url;

    const action = () => this.ajaxAdUnit(this);

    this.appendDisplaySource(this.view.el, display_url);
    this.appendDataToElement(ad.id, material);
    resetInterval(this.cid + 'ad_refresh', action, interval);
  },


  appendDataToElement(ad_id, material){
    Object.assign(this.view.el.dataset, {
      adId: ad_id,
      arriveUrl: material.arrive_url,
      bufferingUrl: material.buffering_file.url,
      displayUrl: material.display_file.url,
      triggerUrl: material.trigger_file.url,
    })
  },


  appendDisplaySource(element, display_url){
    $(element).find('video').remove();
    $(element).children().hide();

    if (display_url.indexOf('mp4') !== -1){
      element.style.backgroundImage = 'url()';
      const video_code = `<video poster="http://cdn.iiiiiii.com/data/transparent.png" class="gjs-no-pointer video-js vjs-default-skin" autoplay style="height: 100%; width: 100%;">
                            <source src="${display_url}" type="video/mp4">
                          </video>`;
      const video = $.parseHTML(video_code);

      $(element).prepend(video)
    }else{
      element.style.backgroundImage = `url(${display_url})`;
    }
  }
}