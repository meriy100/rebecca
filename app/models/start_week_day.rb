class StartWeekDay < ActiveHash::Base
  self.data = [
    { id: 1, name: "日曜", week: :sun, is_sunday: true },
    { id: 2, name: "月曜", week: :mon, is_sunday: false }
  ]

  def week_range(today)
    start_day = today.beginning_of_week
    end_day = today.end_of_week.end_of_day
    if is_sunday
      today.sunday? ? (start_day + 6..end_day + 6.day) : (start_day - 1..end_day - 1.day)
    else
      (start_day..end_day)
    end
  end
end
