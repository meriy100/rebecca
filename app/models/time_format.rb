class TimeFormat < ActiveHash::Base
  self.data = [
    {id: 1, show: "1/1(月)", format: "%m/%d(%a)"},
    {id: 2, show: "2016/1/1(月)", format: "%Y/%m/%d(%a)"},
  ]
end
