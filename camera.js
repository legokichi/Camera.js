var Camera;

Camera = (function() {

  navigator.getUserMedia =
    navigator.getUserMedia ||
    navigator.msGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.webkitGetUserMedia;

  function Camera(option) {
    if (option == null) {
      option = {};
    }
    this.width = option.width || 640;
    this.height = option.height || 480;
    this.useAudio = option.useAudio === void 0 ? true : false;
    this.useVideo = option.useVideo === void 0 ? true : false;
    this.interval = option.interval || 33;
    this.video = option.video || document.createElement("video");
    this.canvas = option.canvas || document.createElement("canvas");
    this.context = this.canvas.getContext("2d");
    this.canvas.width = this.video.width = this.width;
    this.canvas.height = this.video.height = this.height;
  }

  Camera.prototype.setup = function(fn) {
    fn.call(this);
    return this;
  };

  Camera.prototype.draw = function(fn) {
    var error, recur, success,
      _this = this;
    error = function() {
      return alert("There has been a problem retrieving the streams - did you allow access?");
    };
    success = function(stream) {
      _this.video.src = URL.createObjectURL(stream);
      _this.video.autoplay = true;
      return setTimeout(recur, _this.interval);
    };
    recur = function() {
      _this.context.drawImage(_this.video, 0, 0, _this.width, _this.height);
      fn.call(_this);
      return setTimeout(recur, _this.interval);
    };
    navigator.getUserMedia({
      video: this.useVideo,
      audio: this.useAudio
    }, success, error);
    return this;
  };

  return Camera;

})();
