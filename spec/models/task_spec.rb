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

require 'rails_helper'

RSpec.describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
