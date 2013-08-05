class this.Camera
  "use strict"
  # ver 2013-08-06
  navigator.getUserMedia =
    navigator.getUserMedia or
    navigator.msGetUserMedia or
    navigator.mozGetUserMedia or
    navigator.webkitGetUserMedia

  window.URL =
    window.URL or
    window.msURL or
    window.mozURL or
    window.webkitURL

  constructor: (opt)->
    opt ?= {}
    @width    = opt.width  or null
    @height   = opt.height or null
    @interval = opt.interval or 33
    @mirror   = if opt.mirror?   then opt.mirror   else false
    @useAudio = if opt.useAudio? then opt.useAudio else true
    @useVideo = if opt.useVideo? then opt.useVideo else true
    @video    = opt.video  or document.createElement("video")
    @canvas   = opt.canvas or document.createElement("canvas")
    @context  =  @canvas.getContext("2d")

  setup: (fn)->
    @video.addEventListener("loadeddata", (=>
      @width  ?= @video.videoWidth
      @height ?= @video.videoHeight
      @canvas.width  = @video.width  = @width
      @canvas.height = @video.height = @height
      fn.call(@)
      @video.play()
    ), false)
    @

  draw: (fn)->
    @video.addEventListener("play", (=>
      setTimeout(recur, @interval)
    ), false)
    
    recur = =>
      if @mirror
        @context.translate(this.width, 0);
        @context.scale(-1, 1);
        @context.drawImage(@video, 0, 0, @width, @height)
        @context.translate(this.width, 0);
        @context.scale(-1, 1);
      else
        @context.drawImage(@video, 0, 0, @width, @height)
        
      fn.call(@)
      setTimeout(recur, @interval)

    success = (stream)=>
      if @video.mozSrcObject?
        @video.mozSrcObject = stream
      else
        @video.src = window.URL.createObjectURL(stream) or stream

    error = ->
      alert("There has been a problem retrieving the streams - did you allow access?")

    if navigator.getUserMedia?
      navigator.getUserMedia({
        video: @useVideo,
        audio: @useAudio
      }, success, error)
    else
      alert("Native web camera streaming (getUserMedia) not supported in this browser.")
