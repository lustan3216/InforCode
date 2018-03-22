window.tempShow = []

function resetInterval(key, fn, interval){
  if(window[key]) clearInterval(window[key]);
  window[key]= setInterval(fn, interval);
}

function tempShowResetInterval(display_block){

  if(tempShow && tempShow.length > 0){
    tempShow.forEach((e) => clearInterval(e));
    display_block.find('.temp_show_ad').remove();
  }
  window.tempShow = [];
}

function pushIdToTempShow(fn, interval){
  tempShow.push(setTimeout(fn, interval))
}

export { resetInterval, tempShowResetInterval, pushIdToTempShow }