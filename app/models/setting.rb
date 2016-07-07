class Setting < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  include CurrentUser

  belongs_to_active_hash :start_week_day
  belongs_to_active_hash :time_format

  validates :user_id, presence: true, uniqueness: true

  delegate :format, to: :time_format
  delegate :week_range, to: :start_week_day
end
