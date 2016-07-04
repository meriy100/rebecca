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
        task: {
          title: value,
        }
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
    shadow = taskRow.parents(".trello-shadow")
    $.ajax
      url: "/tasks/#{taskId}/done"
      type: "POST"
      dataType: "json"
      success: (results) ->
        $("#tasks-badge").html(results["counts"]["tasks"])
        $("#today-badge").html(results["counts"]["today"])
        $("#weekly-badge").html(results["counts"]["weekly"])
        shadow.addClass("fadeout")
        shadow.fadeOut("slow")
        # ここで, id を指定して data に埋め込む
        $(".notify-modal.done").fadeIn()
        $(".undo-link").data("task", taskId)

  undoTask = (scope) ->
    taskId = $(scope).data("task")
    taskRow = $(scope).parents(".task-row")
    $.ajax
      url: "/tasks/#{taskId}/undo"
      type: "POST"
      dataType: "json"
      success: (results) ->
        $("#tasks-badge").html(results["counts"]["tasks"])
        $("#today-badge").html(results["counts"]["today"])
        $("#weekly-badge").html(results["counts"]["weekly"])
        $("#task-#{taskId}").fadeIn(1000)
        taskRow.fadeOut()
        $(".undo-modal").hide()
        # $("html,body").animate({scrollTop:taskCard.offset().top})
        $(".notify-modal.undo").fadeIn()

  hideModal = ->
    $(".notify-modal").hide()

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
    hideModal()
  $(document).on "click", ".undo-link", ->
    hideModal()
  $(document).on "click", ".task-return", ->
    undoTask(this)

