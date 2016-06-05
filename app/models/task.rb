# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string(255)
#  status      :integer
#  weight      :integer
#  deadline_at :datetime
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  DOING = 1
  DONE = 2

  # belongs_to :user
  include CurrentUser
  acts_as_paranoid

  validates :status, presence: true, inclusion: {in: (DOING..DONE)}
  validates :deadline_at, presence: true
  before_validation :set_status
  before_validation :deadline_at_orver_created_at
  before_save :create_sync_token

  def done
    if status == DOING
      self.update(status: DONE)
    end
  end

  # TODO 仮 設計による
  def least_time
    if deadline_at > Time.zone.now
      deadline_at - Time.zone.now
    else
      0
    end
  end

  def full_time
    deadline_at - created_at
  end

  def least_time_per
    (least_time / full_time * 100).to_i
  end

  def deadline_at_to_s
    today = Time.zone.now
    if deadline_at.between? today, today.next_week
      deadline_at.today? ? "今日" : I18n.l(deadline_at, format: :weekday)
    else
      I18n.l deadline_at, format: :short
    end
  end

  private
  def set_status
    self.status ||= DOING
  end

  # 本当は自作バリデータを作成すべき あとメソッド名がキモイ
  def deadline_at_orver_created_at
    if (created_at || Time.zone.now) > deadline_at
      self.errors[:deadline_at] << ("is over created_at ")
      false
    end
  end

  def create_sync_token
    if sync_token.nil?
      self.sync_token = SecureRandom.uuid
    end
  end
end
