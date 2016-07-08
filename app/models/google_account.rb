class GoogleAccount < ActiveRecord::Base
  include CurrentUser
  has_many :google_calendars
end
