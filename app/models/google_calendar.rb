class GoogleCalendar < ActiveRecord::Base
  include CurrentUser
  belongs_to :google_account
  has_many :events
  enum status: { sync: 1, stop: 2, disable: 3 }
  delegate :access_token, to: :google_account
  delegate :refresh_token, to: :google_account
end
