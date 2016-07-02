$(document).ready ->
  ajaxStateOn = (ajax_state) ->
    ajax_state.addClass("fa-spinner fa-spin")
    ajax_state.addClass("active")

  ajaxStateSuccess = (ajax_state) ->
    ajax_state.removeClass("fa-spinner fa-spin")
    ajax_state.addClass("fa-check")

  ajaxStateFail = (ajax_state) ->
    ajax_state.removeClass("fa-spinner fa-spin")
    ajax_state.addClass("fa-remove")

  selectUpdate = (scope) ->
    ajax_state = $(scope).parent().find(".ajax-state")
    ajaxStateOn(ajax_state)
    target_attr = $(scope).data("attr")
    value = $(scope).val()
    $.ajax
      url: "/setting"
      type: "PATCH"
      dataType: "json"
      data: {
        setting: {
          "#{target_attr}": value
        }
      }
      success: (results) ->
        ajaxStateSuccess(ajax_state)
      error: (results) ->
        ajaxStateFail(ajax_state)

  editUserInfo = (scope) ->
    span = $(scope).data("span")
    input = $(scope).data("input")
    $(span).hide()
    $(input).addClass("active")
    $(scope).removeClass("user-edit-button")
    $(scope).addClass("user-submit-button")
    $(scope).html("登録")

  submitUserName = (scope) ->
    ajax_state = $(scope).parent().find(".ajax-state")
    ajaxStateOn(ajax_state)
    span = $(scope).data("span")
    input = $(scope).data("input")
    value = $(input).val()
    target_attr = $(scope).data("attr")
    $.ajax
      url: "/user/name"
      type: "PATCH"
      dataType: "json"
      data: {
        user: {
          name : value
        }
      }
      success: (results) ->
        ajaxStateSuccess(ajax_state)
        $(input).removeClass("active")
        $(span).show()
          .html(results["name"])
        $(scope).removeClass("user-submit-button")
        $(scope).addClass("user-edit-button")
        $(scope).html("編集")
      error: (results) ->
        ajaxStateFail(ajax_state)
        console.log results
        # ここでエラーの内容を表示

  $(document).on "change", ".setting-select", ->
    selectUpdate(this)
  $(document).on "click", ".user-edit-button", ->
    editUserInfo(this)
  $(document).on "click", "#user-name-submit.user-submit-button", ->
    submitUserName(this)
