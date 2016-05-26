# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string(255)
#  status      :integer
#  deadline_at :datetime
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Task < ActiveRecord::Base
  DOING = 1
  DONE = 2
  TRUSH = 3

  # belongs_to :user
  include CurrentUser
  acts_as_paranoid

  validates :status, presence: true, inclusion: {in: (DOING..DONE)}
  before_validation :set_status

  def done
    if status == DOING
      self.update(status: DONE)
    end
  end

  # TODO 仮 設計による
  def least_time
    deadline_at - Time.zone.now
  end

  def full_time
    deadline_at - created_at
  end

  def least_time_per
    (least_time / full_time * 100).to_i
  end

  private
  def set_status
    self.status ||= DOING
  end
end
