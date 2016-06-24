$(document).ready ->

  $(document).on "click", "#nav-button", ->
    $("#nav-content").toggleClass("nav-content-active")

  $(document).on "click", ".nav-list", ->
    $(".nav-list.current").removeClass("current")
