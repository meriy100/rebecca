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

module TasksHelper
end
