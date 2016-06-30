class StartWeekDay < ActiveHash::Base
  self.data = [
    {id: 1, name: "日曜", week: :sun},
    {id: 2, name: "月曜", week: :mon},
  ]
end
