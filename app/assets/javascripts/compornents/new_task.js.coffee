$(document).ready ->
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

  # weight 用のスライダー

  $(".slider").slider()

# 新規追加フォームがよく見えるようにスクロール
# $("html,body").animate({scrollTop:$('#new-task').offset().top})
# $("#title-input").focus()
# $('.datepicker').on('dp.change', ->(ev)
#   $('#task_deadline_at').val(ev.date.toDate())

