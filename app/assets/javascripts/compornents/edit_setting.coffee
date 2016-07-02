$(document).ready ->
  selectUpdate = (scope) ->
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
        console.log results
      error: (results) ->
        console.log results


  $(document).on "change", ".setting-select", ->
    selectUpdate(this)
