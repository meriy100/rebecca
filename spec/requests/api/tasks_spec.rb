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
    User.current_user = create(:user)
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
        { user: {task_updated_at: (task.updated_at - 1), synced_at: (task.updated_at - 1) }}
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
        { user: { task_updated_at: (task.updated_at + 1), synced_at: task.updated_at}, tasks: [task_params(task)]  }
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
        { user: { task_updated_at: task.updated_at, synced_at: task.updated_at } }
      end
      it "json include message" do
        is_expected.to eq(200)
        body = response.body
        expect(body).to have_json_path("message")
        expect(body).to be_json_eql("\"no_sync\"").at_path("message")
      end
    end
  end

  describe "POST /api/tasks" do
    context "valid params" do
      let(:params) do
        { task: task_params(build(:task)) }
      end

      it "created task" do
        is_expected.to eq(200)
        body = response.body
        expect(Task.count).to eq(1)
      end

      it "return params" do
        is_expected.to eq(200)
        task = Task.first
        body = response.body
        be_json_eql_task(task, "").each do |_, matcher|
          expect(body).to matcher
        end
      end
    end

    context "invalid params" do
      let(:task) { build(:fail_task)}
      let(:params) do
        { task: task_params(task) }
      end

      it "dasnt created task" do
        is_expected.to eq(200)
        body = response.body
        expect(Task.count).to eq(0)
      end

      it "return params" do
        task.deadline_at = task.deadline_at.end_of_day
        is_expected.to eq(200)
        body = response.body
        be_json_eql_task(task, "", :user_id, :sync_token, :created_at, :updated_at).each do |_, matcher|
          expect(body).to matcher
        end
      end
      it "include massage in task" do
        is_expected.to eq(200)
        body = response.body
        expect(body).to be_json_eql(["Deadline atis over created_at "]).at_path("errors")
      end
    end
  end

  describe "POST /api/tasks/:sync_token/done" do
    context "vaild sync_token" do
      let(:task) {create(:task)}
      let(:sync_token) {task.sync_token}
      it "task done" do
        is_expected.to eq(200)
        task.reload
        expect(task.is_done).to eq(true)
      end
      it "include return params" do
        is_expected.to eq(200)
        task.reload
        body = response.body
        be_json_eql_task(task, "").each do |_, matcher|
          expect(body).to matcher
        end
      end
    end

    context "invalid sync_token" do
      let(:task) {build(:sync_task)}
      let(:sync_token) { task.sync_token }
      let(:params) do
        { task: task_params(task) }
      end
      it "create task" do
        is_expected.to eq(200)
        expect(Task.count).to eq(1)
      end
      it "task done" do
        is_expected.to eq(200)
        task = Task.first
        expect(task.is_done).to eq(true)
      end
      it "include return params" do
        is_expected.to eq(200)
        task = Task.first
        body = response.body
        be_json_eql_task(task, "").each do |_, matcher|
          expect(body).to matcher
        end
      end
    end
  end

  describe "PATCH /api/tasks/:sync_token" do
    let(:task) { create(:task) }
    let(:sync_token) { task.sync_token }
    context "valid params" do
      let(:params) do
        { task: task_params(task).merge(title: "テストタスク2") }
      end
      it "updated task" do
        is_expected.to eq(200)
        task.reload
        expect(task.title).to eq("テストタスク2")
      end
      it "return params" do
        is_expected.to eq(200)
        task.reload
        body = response.body
        be_json_eql_task(task, "").each do |_, matcher|
          expect(body).to matcher
        end
      end
    end
    context "invalid params" do
      let(:yesterday) { Time.zone.yesterday.end_of_day }
      let(:params) do
        { task: task_params(task).merge(deadline_at: yesterday) }
      end
      it "didnt updated task" do
        is_expected.to eq(200)
        expect(Task.first).to eq(task)
      end
      it "return params" do
        is_expected.to eq(200)
        task.deadline_at = yesterday
        body = response.body
        be_json_eql_task(task, "").each do |_, matcher|
          expect(body).to matcher
        end
      end
      it "include massage in task" do
        is_expected.to eq(200)
        body = response.body
        expect(body).to be_json_eql(["Deadline atis over created_at "]).at_path("errors")
      end
    end
    context "invalid sync_token" do
      let(:task) {build(:sync_task)}
      let(:sync_token) { task.sync_token }
      let(:params) do
        { task: task_params(task).merge(title: "テストタスク2") }
      end
      it "create task" do
        expect(Task.count).to eq(0)
        is_expected.to eq(200)
        expect(Task.count).to eq(1)
      end
      it "include return params" do
        is_expected.to eq(200)
        task = Task.first
        body = response.body
        be_json_eql_task(task, "", :user_id).each do |_, matcher|
          expect(body).to matcher
        end
      end
    end
  end
end


def be_json_eql_task(task, path, *except_keys)
  {
    user_id: be_json_eql(task.user_id).at_path("#{path}user_id"),
    title: be_json_eql("\"#{task.title}\"").at_path("#{path}title"),
    sync_token: be_json_eql("\"#{task.sync_token}\"").at_path("#{path}sync_token"),
    is_done: be_json_eql(task.is_done).at_path("#{path}is_done"),
    weight: be_json_eql(task.weight).at_path("#{path}weight"),
    deadline_at: be_json_eql("\"#{task.deadline_at.try(:strftime, "%Y-%m-%d %H:%M:%S")}\"").at_path("#{path}deadline_at"),
    created_at: be_json_eql("\"#{task.created_at.try(:strftime, "%Y-%m-%d %H:%M:%S")}\"").at_path("#{path}created_at"),
    updated_at: be_json_eql("\"#{task.updated_at.try(:strftime, "%Y-%m-%d %H:%M:%S")}\"").at_path("#{path}updated_at"),
  }.tap do |matchers|
    except_keys.each { |except_key| matchers.delete(except_key) }
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
    except_keys.each { |except_key| hash.delete(except_key) }
  end
end
