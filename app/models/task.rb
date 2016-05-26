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
  # belongs_to :user
  include CurrentUser
  acts_as_paranoid

  def done

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

end
