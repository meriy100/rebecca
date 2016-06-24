$(document).on "ready page:load", ->

  $(document).on "click", "#nav-button", ->
    $("#nav-content").toggleClass("nav-content-active")

  $(document).on "click", ".nav-list", ->
    $(".nav-list.current").removeClass("current")
  $(".nav-list-slide").bind({
    "touchstart" : (e) ->
    "touchmove" : (e) ->
      if event.changedTouches[0].clientX > 0
        $("#nav-content").addClass("nav-content-active")
  })
  $("#nav-content").bind({
    "touchstart" : (e) ->
      @positionX = event.changedTouches[0].clientX
    "touchmove" : (e) ->
      if @positionX - event.changedTouches[0].clientX  > 100
        $("#nav-content").removeClass("nav-content-active")
  })
