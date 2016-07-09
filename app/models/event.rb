class Event < ActiveRecord::Base
  include CurrentUser
  belongs_to :google_calendar
  has_many :tasks

  scope :on_user, -> { where user: User.current_user }
end
