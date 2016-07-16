class Event < ActiveRecord::Base
  include CurrentUser
  belongs_to :google_calendar
  has_many :tasks
  has_one :setting, through: :user

  scope :on_user, -> { where user: User.current_user }
  enum status: { show: 1, hidden: 2 }

  def date_to_s
    today = Time.zone.now
    format = if date.between? today, setting.week_range(today).last
               date.today? ? :today : :weekday
             else
               setting.format
             end
    I18n.l date, format: format
  end
end
