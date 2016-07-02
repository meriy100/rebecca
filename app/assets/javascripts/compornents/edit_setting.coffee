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


  $(document).on "change", ".setting-select", ->
    selectUpdate(this)
