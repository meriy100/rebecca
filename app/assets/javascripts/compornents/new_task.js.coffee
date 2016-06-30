$(document).on "ready page:load", ->
  $('.datepicker').datetimepicker({
    inline: true,
    format : "YYYY/MM/DD",
    icons: {
      previous: "fa fa-arrow-left",
      next: "fa fa-arrow-right"
    },
    minDate: moment()
  })
  $('#task_deadline_at').val($('.datepicker').data("DateTimePicker").date())
  $('.datepicker').on 'dp.change', (ev)->
    $('#task_deadline_at').val(ev.date.toDate())
  $('.datepicker-days .picker-switch').removeAttr('title').on 'click', (ev) ->
    ev.stopPropagation()

  # weight 用のスライダー

  $(".slider").slider()

  $(document).on "click", "#new-button-sp", ->
    $(".right-side").addClass("active")
  $(document).on "click", ".close", ->
    $(".right-side").removeClass("active")
# 新規追加フォームがよく見えるようにスクロール
# $("html,body").animate({scrollTop:$('#new-task').offset().top})
# $("#title-input").focus()

$(document).on "keyup", "input[id='title-input']", ->
  if isBlank($(this).val())
    $("input[name='commit']").prop('disabled', true)
    $(".ice-submit").addClass("disabled")
  else
    $("input[name='commit']").prop('disabled', false)
    $(".ice-submit").removeClass("disabled")

$(document).on "submit", "form.new_task", ->
  $("input[name='commit']").prop('disabled', true)
  $(".ice-submit").addClass("disabled")

# '==='が使えない理由がワカラナイ
isBlank = (obj) ->
  !obj || $.trim(obj) == ""