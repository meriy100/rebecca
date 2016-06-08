class Task < ActiveRecord::Base
  # belongs_to :user
  include CurrentUser

  before_validation :set_is_done
  before_validation :deadline_at_orver_created_at
  before_validation :set_sync_token

  validates :sync_token, presence: true, uniqueness: true
  validates :deadline_at, presence: true

  scope :on_user, -> { where(user: current_user) }

  def done
    update(is_done: true) unless is_done
  end

  # TODO
  # 仮 設計による
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

  def set_is_done
    self.is_done ||= false
    true
  end

  # 本当は自作バリデータを作成すべき あとメソッド名がキモイ
  def deadline_at_orver_created_at
    if (created_at || Time.zone.now) > deadline_at
      errors[:deadline_at] << "is over created_at "
      false
    end
  end

  def set_sync_token
    self.sync_token = SecureRandom.uuid if sync_token.nil?
  end
end
