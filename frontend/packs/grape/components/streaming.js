import { tempShowResetInterval } from './reset_interval'

export default function (domComps, dModel, dView){

  domComps.addType('Streaming', {
    model: dModel.extend({
      defaults: Object.assign({}, dModel.prototype.defaults, {
        traits: [
          {
            type: 'text',
            label: 'Video Url',
            name: 'data-url',
          }],
      }),
    }, {
      isComponent(el) {
        if(el.tagName === 'DIV' && el.attributes.name && el.attributes.name.value === 'streaming'){
          return {type: 'Streaming'};
        }
      },
    }),
    view: dView.extend({
      events: {
        click: 'showStreaming',
      },
      showStreaming(e) {
        const url = e.target.dataset.url;
        const displayBlock = $(e.target).parents('body').find('.display_block');

        if (displayBlock[0] && url){
          const videoCode = '<video class="gjs-no-pointer video-js vjs-default-skin" style="height: 100%; width: 100%;"></video>';

          tempShowResetInterval(displayBlock);

          displayBlock.find('video').remove();
          displayBlock.find('.temp_show_ad').remove();
          displayBlock.append(videoCode);
          const video = displayBlock.find('video')[0];

          this.playVideo(url, video)
        }
      },
      playVideo(url, video){
        if(Hls.isSupported()) {
          const hls = new Hls();

          hls.loadSource(url);
          hls.attachMedia(video);
          hls.on(Hls.Events.MANIFEST_PARSED, () => video.play());
        }
      }
    })
  });

}
