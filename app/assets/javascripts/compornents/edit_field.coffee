$(document).ready ->
  updateTask = (scope) ->
    task_id = $(scope).data("task")
    value = $(scope).find("input").val()
    $(scope).hide()
    value_span = $(scope).parent().find(".task-name-value")
    value_span.show()
    $.ajax
      url: "tasks/#{task_id}"
      type: "PATCH"
      dataType: "html"
      data: {
        id: task_id,
        atr: "name",
        value: value,
      }
      success: (results) ->
        value_span.html(value)

  showNameField = (scope) ->
    task_id = $(scope).data("task")
    $(scope).hide()
    field = $(scope).parent().find(".task-name-field")
    field.show()
    field.find("input").focus()

  $(document).on "click", ".task-name-value", ->
    showNameField(this)
  $(document).on "blur", ".task-name-field", ->
    updateTask(this)
