require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_session) { { user_id: 1 } }

  before do
    create(:user)
  end

  describe "GET #index" do
    let(:tasks) { create_list(:task, 10) }
    before do
      tasks.sample(5).each(&:done)
      get :index, {}, valid_session
    end
    it "render index" do
      expect(response).to render_template :index
    end
    it "assings doing tasks" do
      expect(assigns(:tasks)).to match(Task.doings)
    end
    it "assigns dont include completeds tasks" do
      expect(assigns(:tasks)).not_to match(Task.completeds)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:create_params) { { task: attributes_for(:task), format: :js } }
      before do
        post :create, create_params, valid_session
      end
      it "creates a new Task" do
        expect(Task.count).to eq 1
      end

      it "assigns a newly created task as @task" do
        expect(assigns(:task)).to be_a Task
        expect(assigns(:task)).to be_persisted
      end

      it "redirects to the created task" do
        expect(response).to render_template(:create)
      end
    end

    context "with invalid params" do
      let(:create_params) { { task: attributes_for(:fail_task), format: :js } }
      before do
        post :create, create_params, valid_session
      end
      it "assigns a newly created but unsaved task as @task" do
        expect(assigns(:task)).to be_a_new Task
      end
      it "re-renders the 'new' template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "POST #done" do
    let(:task) { create(:task) }
    before do
      post :done, { id: task.id }, valid_session
    end
    it "task.is_done is true" do
      expect(Task.first.is_done).to be_truthy
    end
    it "return task json" do
      json = JSON.parse response.body
      expect(json["id"]).to eq task.id
    end
  end

  describe "POST #undo" do
    let(:task) { create(:doned_task) }
    before do
      post :undo, { id: task.id }, valid_session
    end
    it "task.is_done is true" do
      expect(Task.first.is_done).to be_falsey
    end
    it "return task json" do
      json = JSON.parse response.body
      expect(json["id"]).to eq task.id
    end
  end

  describe "GET #completed" do
    let(:tasks) { create_list(:task, 10) }
    before do
      tasks.sample(5).each(&:done)
      get :completed, {}, valid_session
    end
    it "assigns all tasks as @tasks" do
      expect(response).to render_template :completed
    end
    it "return except doing tasks" do
      expect(assigns(:tasks)).to match_array(Task.completeds)
    end
    it "return except doing tasks" do
      expect(assigns(:tasks)).not_to match_array(Task.doings)
    end
  end

  describe "PUT #update" do
    let(:task) { create(:task) }
    context "with valid params" do
      let(:new_attributes) { { atr: "title", value: "テストタスク2", format: :js } }
      before do
        new_attributes[:id] = task.id
        put :update, new_attributes, valid_session
      end

      it "updates the requested task" do
        task.reload
        expect(task.title).to eq("テストタスク2")
      end

      it "assigns the requested task as @task" do
        expect(assigns(:task)).to eq task
      end

      it "return status 200" do
        expect(response.status).to eq 200
      end
      it "return json of taks" do
        json = JSON.parse response.body
        expect(json["id"]).to eq task.id
      end
    end

    context "with invalid params" do
      before do
        put :update, { id: task.to_param, atr: "deadline_at", value: Time.zone.yesterday, format: :js }, valid_session
      end
      it "assigns the task as @task" do
        expect(assigns(:task)).to eq(task)
      end

      it "re-renders the 'edit' template" do
        expect(response.status).to eq(501)
      end
    end
  end

  describe "GET #todays" do
    let(:today_task) { create(:today_task) }
    let(:tomorrow_task) { create(:task) }
    let(:completed_task) { create(:doned_task) }
    before do
      today_task
      tomorrow_task
      completed_task
      get :today, {}, valid_session
    end
    it "assigns all tasks as @tasks" do
      expect(response).to render_template :filter
    end
    it "return except todays tasks" do
      expect(assigns(:tasks)).to match_array(today_task)
    end
    it "return not except tomorrow tasks" do
      expect(assigns(:tasks)).not_to match_array(tomorrow_task)
    end
    it "return not except completed tasks" do
      expect(assigns(:tasks)).not_to match_array(completed_task)
    end
  end

  describe "GET #weekly" do
    let(:today_task) { create(:today_task) }
    let(:completed_task) { create(:doned_task) }
    before do
      today_task
      completed_task
      get :weekly, {}, valid_session
    end
    it "assigns all tasks as @tasks" do
      expect(response).to render_template :filter
    end
    it "return except todays tasks" do
      expect(assigns(:tasks)).to match_array(today_task)
    end
    it "return not except completed tasks" do
      expect(assigns(:tasks)).not_to match_array(completed_task)
    end
  end
end
