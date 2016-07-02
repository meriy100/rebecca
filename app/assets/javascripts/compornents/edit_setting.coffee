$(document).ready ->
  selectUpdate = (scope) ->
    ajax_state = $(scope).parent().find(".ajax-state")
    ajax_state.addClass("fa-spinner fa-spin")
    ajax_state.addClass("active")
    target_attr = $(scope).data("attr")
    value = $(scope).val()
    $.ajax
      url: "settings"
      type: "PATCH"
      dataType: "json"
      data: {
        setting: {
          attr: target_attr,
          value: value
        }
      }
      success: (results) ->
        ajax_state.removeClass("fa-spinner fa-spin")
        ajax_state.addClass("fa-check")
      error: (results) ->
        console.log
        ajax_state.removeClass("fa-spinner fa-spin")
        ajax_state.addClass("fa-remove")

  editUserInfo = (scope) ->
    span = $(scope).data("span")
    input = $(scope).data("input")
    $(span).hide()
    $(input).addClass("active")
    $(scope).removeClass("user-edit-button")
    $(scope).addClass("user-submit-button")
    $(scope).html("登録")

  submitUserInfo = (scope) ->
    span = $(scope).data("span")
    input = $(scope).data("input")
    value = $(input).val()
    target_attr = $(scope).data("attr")
    $.ajax
      url: "/"
      type: "PATCH"
      dataType: "json"
      data: {
        user: {
          attr: target_attr,
          value: value
        }
      }
      success: (results) ->
        $(input).removeClass("active")
        $(span).show()
        $(scope).removeClass("user-submit-button")
        $(scope).addClass("user-edit-button")
        $(scope).html("編集")

  $(document).on "change", ".setting-select", ->
    selectUpdate(this)
  $(document).on "click", ".user-edit-button", ->
    editUserInfo(this)
  $(document).on "click", ".user-submit-button", ->
    submitUserInfo(this)
