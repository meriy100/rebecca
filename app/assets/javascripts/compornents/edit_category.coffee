$(document).ready ->
  $(document).on "click", ".new-category", ->
    $(".new-category-form").show()
  $(document).on "click", ".icon-cand", ->
    console.log($(this).find(".fa").attr("value"))
    $("#category_icon_id").val($(this).find("i").attr("value"))
  $(document).on "click", ".color-cand", ->
    $("#category_color_id").val($(this).find("font").attr("value"))