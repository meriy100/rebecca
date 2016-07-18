$(document).ready ->
  $(document).on "click", ".new-category", ->
    $(".new-category-form").show()
    $("input[type='radio']").val(['1'])
    $("input[type='radio']").parent(".btn").removeClass("btn-selected")
    $("input[type='radio']:checked").parent(".btn").addClass("btn-selected")
  $(document).on "click", ".new-category-form-cancel", ->
    $(".new-category-form").hide()
  $(document).on "change", "input[type='radio']", ->
    console.log("changed")
    $("input[type='radio']").parent(".btn").removeClass("btn-selected")
    $("input[type='radio']:checked").parent(".btn").addClass("btn-selected")
