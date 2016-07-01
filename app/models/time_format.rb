class TimeFormat < ActiveHash::Base
  self.data = [
    {id: 1, show: "1/1(月)", format: :a},
    {id: 2, show: "2016/1/1(月)", format: :b},
    {id: 3, show: "01/01(月)", format: :c},
    {id: 4, show: "2016/01/01(月)", format: :d},
  ]
end
