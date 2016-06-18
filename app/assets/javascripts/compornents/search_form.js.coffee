$(document).ready ->
  $(document).on "focus", ".non-focus", ->
    $(this).removeClass("non-focus")
    $(this).addClass("input-group-focus")
    $("#search-submit").removeClass("hide")
    # $("#search-submit").addClass("show")

  $(document).on "blur", ".input-group-focus", ->
    $(this).removeClass("input-group-focus")
    $(this).addClass("non-focus")
    # $("#search-submit").removeClass("show")
    $("#search-submit").addClass("hide")
    $("#search-form").submit()

