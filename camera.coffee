class this.Camera
  "use strict"

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
    @useAudio = if opt.useAudio? then opt.useAudio else true
    @useVideo = if opt.useVideo? then opt.useAudio else true
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
    success = (stream)=>
      if @video.mozSrcObject?
        @video.mozSrcObject = stream
      else
        @video.src = window.URL.createObjectURL(stream) or stream
      @video.addEventListener("play", (=>
        setTimeout(recur, @interval)
      ), false)

    recur = =>
      @context.drawImage(@video, 0, 0, @width, @height)
      fn.call(@)
      setTimeout(recur, @interval)

    error = ->
      alert("There has been a problem retrieving the streams - did you allow access?")

    if navigator.getUserMedia?
      navigator.getUserMedia({
        video: @useVideo,
        audio: @useAudio
      }, success, error)
    else
      console.log('Native web camera streaming (getUserMedia) not supported in this browser.');
