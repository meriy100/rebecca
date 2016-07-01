class Setting < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  include CurrentUser
  belongs_to_active_hash :start_week_day
  belongs_to_active_hash :time_format

  def start_pages
    [
      ["タスク一覧", 1],
      ["今日のタスク", 2],
      ["今週のタスク", 3]
    ]
  end
end
