$(document).ready ->

  $(document).on "click", "#nav-button", ->
    $("#nav-content").toggleClass("nav-content-active")
