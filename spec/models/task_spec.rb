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
  describe "when create" do
    context "with vaild params" do
      let(:task) { create(:task) }
      it "task created" do
        task
        expect(Task.count).to eq(1)
      end
      it "is_done = false Task create" do
        expect(task.is_done).to eq(false)
      end
      it "sync_token" do
        expect(task.sync_token).not_to eq(nil)
      end
    end
    context "with invaild params" do
      it "task dont created" do
        task = Task.create(attributes_for(:fail_task))
        expect(Task.count).to eq(0)
      end
    end
  end
  describe "deadline_at" do
    let(:task) { create(:task) }
    it "least_time_per" do
      expect(task.least_time_per).to eq(((task.deadline_at - Time.zone.now)/ (task.deadline_at - task.created_at) * 100).to_i)
    end
  end
end
