require 'rails_helper'


RSpec.describe TasksController, type: :controller do

  let(:valid_attributes) {
  }

  let(:invalid_attributes) {
  }

  let(:valid_session) { {user_id: 1} }

  before do
    create(:user)
  end

  describe "GET #index" do
    it "assigns all tasks as @tasks" do
      get :index, {}, valid_session
      expect(response).to render_template :index
    end
    it "return tasks" do
      task = create(:task)
      get :index, {}, valid_session
      expect(assigns(:tasks)).to match([task])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, {task: attributes_for(:task), format: :js}, valid_session
        }.to change(Task, :count).by(1)
      end

      it "assigns a newly created task as @task" do
        post :create, {task: attributes_for(:task), format: :js}, valid_session
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).to be_persisted
      end

      it "redirects to the created task" do
        post :create, {task: attributes_for(:task), format: :js}, valid_session
        expect(response).to render_template(:create)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved task as @task" do
        post :create, {task: attributes_for(:fail_task), format: :js}, valid_session
        expect(assigns(:task)).to be_a_new(Task)
      end

      it "re-renders the 'new' template" do
        post :create, {task: attributes_for(:fail_task), format: :js}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "POST #done" do
    pending "done"
  end

  describe "GET #doned" do
    it "assigns all tasks as @tasks" do
      get :doned, {}, valid_session
      expect(response).to render_template :doned
    end
    it "return except doing tasks" do
      task = create(:doned_task)
      get :doned, {}, valid_session
      expect(assigns(:tasks)).to match([task])
    end
    it "return except doing tasks" do
      task = create(:task)
      get :doned, {}, valid_session
      expect(assigns(:tasks)).not_to match([task])
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {atr: "title", value: "テストタスク2"}
      }

      it "updates the requested task" do
        task = create(:task)
        put :update, {id: task.to_param, atr: "title", value: "テストタスク2", format: :js}, valid_session
        task.reload
        expect(task.title).to eq("テストタスク2")
      end

      it "assigns the requested task as @task" do
        task = create(:task)
        put :update, {id: task.to_param, atr: "title", value: "テストタスク2", format: :js}, valid_session
        expect(assigns(:task)).to eq(task)
      end

      it "redirects to the task" do
        skip("まだなにも返してない")
      end
    end

    context "with invalid params" do
      it "assigns the task as @task" do
        task = create(:task)
        put :update, {id: task.to_param, atr: "deadline_at", value: Time.zone.yesterday, format: :js}, valid_session
        expect(assigns(:task)).to eq(task)
      end

      it "re-renders the 'edit' template" do
        skip("まだなにも返してない")
      end
    end
  end

  describe "DELETE #destroy" do
    pending "destroy"
    # it "destroys the requested task" do
    #   task = Task.create! valid_attributes
    #   expect {
    #     delete :destroy, {:id => task.to_param}, valid_session
    #   }.to change(Task, :count).by(-1)
    # end
    #
    # it "redirects to the tasks list" do
    #   task = Task.create! valid_attributes
    #   delete :destroy, {:id => task.to_param}, valid_session
    #   expect(response).to redirect_to(tasks_url)
    # end
  end

end
