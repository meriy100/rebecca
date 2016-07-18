$(document).ready ->
  $(document).on "click", ".new-category", ->
    $(".modal-background").show()
    $("input[type='radio']").val(['1'])
    $("input[type='radio']").parent(".btn").removeClass("btn-selected")
    $("input[type='radio']:checked").parent(".btn").addClass("btn-selected")
    console.log("hage")
  $(document).on "click", ".new-category-form-cancel", ->
    $(".modal-background").hide()
  $(document).on "change", "input[type='radio']", ->
    $("input[type='radio']").parent(".btn").removeClass("btn-selected")
    $("input[type='radio']:checked").parent(".btn").addClass("btn-selected")
    console.log($("input[type='radio']:checked"))
  $(document).on "change", "#category-name-input", ->
    console.log("hoge")
    changeTitleInput(this)
  $(document).on "keypress", "#category-name-input", ->
    changeTitleInput(this)
  $(document).on "keyup", "#category-name-input", ->
    changeTitleInput(this)
  changeTitleInput = (scope) ->
    if isBlank($(scope).val())
      $("#new-category-submit").prop('disabled', true)
      $("#new-category-submit-ice").addClass("disabled")
    else
      $("#new-category-submit").prop('disabled', false)
      $("#new-category-submit-ice").removeClass("disabled")

isBlank = (obj) ->
  !obj || $.trim(obj) == ""