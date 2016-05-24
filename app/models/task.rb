class Task < ActiveRecord::Base
  # belongs_to :user
  include CurrentUser
  acts_as_paranoid

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
