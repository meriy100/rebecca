class GoogleCalendar < ActiveRecord::Base
  include CurrentUser
  belongs_to :google_account
  enum status: { sync: 1, abort: 2 }

end
