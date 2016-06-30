class Setting < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  include CurrentUser
  belongs_to_active_hash :start_week_day
  belongs_to_active_hash :time_format
end
