Camera.js
======================
  using Web Camera by getUserMedia

Demo
----------
http://jsdo.it/DUxCA/wIQF

Usage
----------
    new Camera({
      width: 320,
      height:240,
      delay:0
    }).setup(function(){
      document.body.appnedChild(this.canvas);
    }).draw(function(){
      var imgdata = this.context.getImageData(0, 0, this.width, this.height);
      var data = imgdata.data;
      for(var i=0; i<data.length; i+=4){
        //data[i]   = 0 // R
        //data[i+1] = 0 // G
        //data[i+2] = 0 // B
        data[i+3] = 128 // A
      }
      this.context.putImageData(imgdata, 0, 0);
    });

License
----------
Creative Commons [CC BY-SA 3.0](http://creativecommons.org/licenses/by-sa/3.0/)

Author
----------
Legokichi Duckscallion