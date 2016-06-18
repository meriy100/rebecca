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
        atr: "title",
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

  doneTask = (scope) ->
    taskId = $(scope).data("task")
    taskRow = $(scope).parents(".task-row")
    $.ajax
      url: "tasks/#{taskId}/done"
      type: "POST"
      dataType: "html"
      success: (results) ->
        taskRow.fadeOut()
        # ここで, id を指定して data に埋め込む
        $(".undo-modal").fadeIn()
        $(".undo-link").attr("href", "tasks/#{taskId}/undo")

  hideUndoModal = ->
    $(".undo-modal").hide()

  $(document).on "click", ".task-name-value", ->
    showNameField(this)
  $(document).on "blur", ".task-name-field", ->
    updateTask(this)
  $(document).on "mouseenter", ".task-row", ->
    $(this).find(".done-button").show()
  $(document).on "mouseleave", ".task-row", ->
    $(this).find(".done-button").hide()
  $(document).on "click", ".task-done", ->
    doneTask(this)
  $(document).on "click", "span.modal-hide", ->
    hideUndoModal()
