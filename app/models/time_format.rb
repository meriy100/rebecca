class TimeFormat < ActiveHash::Base
  self.data = [
    {id: 1, format: "%m%d(%a)"},
    {id: 2, format: "%Y%m%d(%a)"},
  ]
end
