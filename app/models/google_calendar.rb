class GoogleCalendar < ActiveRecord::Base
  include CurrentUser
  belongs_to :google_account
  has_many :events
  enum status: { sync: 1, abort: 2 }

end
