$(document).ready ->
  $(document).on "focus", ".non-focus", ->
    $(this).removeClass("non-focus")
    $(this).addClass("input-group-focus")

  $(document).on "blur", ".input-group-focus", ->
    $(this).removeClass("input-group-focus")
    $(this).addClass("non-focus")

