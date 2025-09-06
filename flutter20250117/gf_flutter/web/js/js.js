function js_fullscreen(index) {
    //元素id2实现全屏
    // var element= document.getElementById("videoElement-2");//id会随着切换而变化
    var element= document.getElementsByTagName("video")[index];//返回的是数组
    console.log(element);
  
    if (element.requestFullscreen) {
        element.requestFullscreen();
    } else if (element.mozRequestFullScreen) {
        element.mozRequestFullScreen();
    } else if (element.msRequestFullscreen) {
        element.msRequestFullscreen();
    } else if (element.webkitRequestFullscreen) {
        element.webkitRequestFullScreen();
    }
   
  keyEvent(122)
   
   return "js_ok";
  }
  