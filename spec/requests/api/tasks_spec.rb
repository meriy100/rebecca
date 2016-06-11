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

RSpec.describe "Api::Tasks", type: :request do
  let(:headers) do
    { 'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end
  before do
    create(:user)
    post "/api/login", login_user: "test_user", password: "testpass"
  end
  describe "GET /api/tasks" do
    context "tasks in DB" do
      let(:task) { create(:task) }
      it "works! (now write some real specs)" do
        create(:task)
        is_expected.to eq(200)
      end
      it "json include tasks info" do
        task.reload
        is_expected.to eq(200)
        expect(response.body).to have_json_path("tasks")
        expect(response.body).to have_json_type(Array).at_path("tasks")
        expect(response.body).to have_json_size(1).at_path("tasks")
        expect(response.body).to include_json([task_params(task)].to_json)
      end
      it "json include user info" do
        is_expected.to eq(200)
        expect(response.body).to have_json_path("user")
        expect(response.body).to include_json({ email: "test@test.com", name: "test_user" }.to_json)
      end
    end
  end

  describe "POST /api/tasks/sync" do
    let(:task) { create(:task) }
    context "sync" do
      let(:params) do
        { task_updated_at: (task.updated_at - 1), synced_at: (task.updated_at - 1) }
      end
      it "json include message" do
        is_expected.to eq(200)
        body = response.body
        expect(body).to have_json_path("message")
        expect(body).to be_json_eql("\"sync\"").at_path("message")
      end
      it "json include tasks info" do
        task.reload
        is_expected.to eq(200)
        expect(response.body).to have_json_path("tasks")
        expect(response.body).to have_json_type(Array).at_path("tasks")
        expect(response.body).to have_json_size(1).at_path("tasks")
        expect(response.body).to include_json([task_params(task)].to_json)
      end
    end

    context "full sync" do
      let(:params) do
        { task_updated_at: (task.updated_at + 1), synced_at: task.updated_at, tasks: [task_params(task)] }
      end
      let(:task) { create(:task) }
      it "json include message" do
        is_expected.to eq(200)
        body = response.body
        expect(body).to have_json_path("message")
        expect(body).to be_json_eql("\"full_sync\"").at_path("message")
      end
      it "json include tasks info" do
        is_expected.to eq(200)
        expect(response.body).to have_json_path("tasks")
        expect(response.body).to have_json_type(Array).at_path("tasks")
        expect(response.body).to have_json_size(1).at_path("tasks")
        expect(response.body).to include_json([task_params(task)].to_json)
      end
      it "tasks update" do
        task.title = "タスク2"
        task.updated_at = task.updated_at + 1
        is_expected.to eq(200)
        expect(response.body).to include_json([task_params(task)].to_json)
        task.reload
        expect(task.title).to eq("タスク2")
      end
      it "tasks create" do
        response_task = build(:sync_task)
        params[:tasks] << response_task
        is_expected.to eq(200)
        expect(Task.count).to eq(2)
        expect(Task.first).to eq(task)
        expect(Task.last.sync_token).to eq(response_task.sync_token)
        expect(Task.last.title).to eq("テストタスク2")
      end
    end

    context "no sync" do
      let(:params) do
        { task_updated_at: task.updated_at, synced_at: task.updated_at }
      end
      it "json include message" do
        is_expected.to eq(200)
        body = response.body
        expect(body).to have_json_path("message")
        expect(body).to be_json_eql("\"no_sync\"").at_path("message")
      end
    end
  end
end

def task_params(task, *except_keys)
  {
    user_id: task.user_id, sync_token: task.sync_token,
    title: task.title, weight: task.weight,
    is_done: task.is_done,
    deadline_at: task.deadline_at.try(:strftime, "%Y-%m-%d %H:%M:%S"),
    created_at: task.created_at.try(:strftime, "%Y-%m-%d %H:%M:%S"),
    updated_at: task.updated_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  }.tap do |hash|
    except_keys.each { |except_key| hash.delete(except_key)}
  end
end
