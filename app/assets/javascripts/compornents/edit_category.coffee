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

changeTitleInput = (scope) ->
  if isBlank($(scope).val())
    $("#new-category-submit").prop('disabled', true)
    $("#new-category-submit-ice").addClass("disabled")
  else
    $("#new-category-submit").prop('disabled', false)
    $("#new-category-submit-ice").removeClass("disabled")

$(document).on "change", "#category-name-input", ->
  changeTitleInput(this)
$(document).on "keypress", "#category-name-input", ->
  console.log("key")
  changeTitleInput(this)
$(document).on "keyup", "#category-name-input", ->
  changeTitleInput(this)

isBlank = (obj) ->
  !obj || $.trim(obj) == ""