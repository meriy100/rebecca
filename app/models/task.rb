class Task < ActiveRecord::Base
  # belongs_to :user
  include CurrentUser
  has_one :setting, through: :user
  belongs_to :event
  belongs_to :category

  before_validation :set_is_done
  before_validation :set_end_of_date
  before_validation :set_sync_token
  before_validation :set_weight
  after_initialize :set_deadline_at

  validate :deadline_at_over_created_at
  validates :sync_token, presence: true, uniqueness: true
  validates :deadline_at, presence: true
  validates :title, presence: true

  scope :on_user, -> { where user: User.current_user }
  scope :doings, -> { where is_done: false }
  scope :completeds, -> { where is_done: true }
  scope :todays, -> { where deadline_at: Time.zone.today..Time.zone.today.end_of_day }
  scope :weeklys, -> { where deadline_at: setting.week_range(Time.zone.today) }

  def self.setting
    User.current_user.setting
  end

  def self.doing_counts
    tasks = on_user.doings
    {
      tasks: tasks.count,
      today: tasks.todays.count,
      weekly: tasks.weeklys.count
    }
  end

  def done
    update(is_done: true) unless is_done
  end

  def undo
    update(is_done: false)
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
    (least_time / full_time * 100).to_i / weight
  end

  def deadline_at_to_s
    today = Time.zone.now
    format = if deadline_at.between? today, setting.week_range(today).last
               deadline_at.today? ? :today : :weekday
             else
               setting.format
             end
    I18n.l deadline_at, format: format
  end

  def progress_color
    case least_time_per
    when 0...30
      "danger"
    when 30...60
      "warning"
    when 60...100
      "primary"
    else
      "primary"
    end
  end

  private

  def set_is_done
    self.is_done ||= false
    true
  end

  def set_end_of_date
    self.deadline_at &&= deadline_at.end_of_day
  end

  # 本当は自作バリデータを作成すべき あとメソッド名がキモイ
  def deadline_at_over_created_at
    if deadline_at.nil?
      true
    elsif (created_at || Time.zone.now) > deadline_at
      errors[:deadline_at] << "is over created_at "
    end
  end

  def set_sync_token
    self.sync_token = SecureRandom.uuid if sync_token.nil?
  end

  def set_weight
    self.weight ||= 1.0
  end

  def set_deadline_at
    self.deadline_at ||= Time.zone.now.end_of_day
  end
end
