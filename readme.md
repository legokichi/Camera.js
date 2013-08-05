Camera.js
======================
  using Web Camera by getUserMedia

Demo
----------
http://jsdo.it/DUxCA/6o6i

Usage
----------
    new Camera({
      /* options
      width:    [default: video.videoWidth]  (canvas and video elements width)
      height:   [default: video.videoHeight] (canvas and video elements height)
      interval: [default: 33] (30fps = 1s/33ms)
      mirror:   [default: false] (flip horizontal‎)
      useAudio: [default: true]
      useVideo: [default: true]
      video:    [default: document.createElement("video")]
      canvas:   [default: document.createElement("canvas")]
      context:  [default: canvas.getContext("2d")]
      */
      width:    320,
      height:   240,
      useAudio: false
    }).setup(function(){
      document.body.appendChild(this.canvas);
    }).draw(function(){
      var imgdata = this.context.getImageData(0, 0, this.width, this.height);
      var data = imgdata.data;
      for(var i=0; i<data.length; i+=4){
        data[i]   = 0; // R
        //data[i+1] = 0; // G
        //data[i+2] = 0; // B
        //data[i+3] = 127; // A
      }
      this.context.putImageData(imgdata, 0, 0);
    });

License
----------
Creative Commons [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/)

Author
----------
Legokichi Duckscallion