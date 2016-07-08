require 'rails_helper'

RSpec.describe Categories::TasksController, type: :controller do
  let(:valid_session) { { user_id: 1 } }
  let(:user) { create(:user) }
  before do
    user
  end

  describe "GET #index" do
    let(:category) { create :category }
    let(:other_category) { create :other_category }
    let(:tasks) do
      create_list(:task, 10) do |task|
        task.category = category
      end
    end
    let(:other_category_tasks) do
      create_list(:task, 10) do |task|
        task.category = category
      end
    end
    context "render or redirect" do
      it "render index" do
        get :index, { category_id: category.id }, valid_session
        expect(response).to render_template :index
      end
    end
    context "assings" do
      before do
        tasks.sample(5).each(&:done)
        get :index, { category_id: category.id }, valid_session
        tasks.reload
      end
      it "doing tasks on category" do
        expect(assigns(:tasks)).to include category.tasks.doings
      end
      it "dont include doing tasks on other_category" do
        expect(assigns(:tasks)).not_to include other_category.tasks.doings
      end
      it "dont include completeds tasks on category" do
        expect(assigns(:tasks)).not_to include category.tasks.completeds
      end
    end
  end
end
