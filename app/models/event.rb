class Event < ActiveRecord::Base
  include CurrentUser
  belongs_to :google_calendar
  has_many :tasks
end
