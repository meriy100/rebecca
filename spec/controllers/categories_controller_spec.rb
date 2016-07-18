require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:valid_session) { { user_id: 1 } }
  let(:user) { create(:user) }

  before do
    user
  end

  describe "POST #create" do
    context "with valid params" do
      let(:create_params) { { category: attributes_for(:caetgory), format: :js } }
      before do
        post :create, create_params, valid_session
      end
      it "creates a new Category" do
        expect(Category.count).to eq 1
      end
      it "return json category" do
        json = JSON.parse(response)
        expect(json["name"]).to category.name
      end
    end

    context "with invalid params" do
      let(:create_params) { { category: attributes_for(:invaild_category), format: :js } }
      before do
        post :create, create_params, valid_session
      end
      it "return status 501" do
        expect(response.status).to eq 501
      end
      it "return json error" do
        json = JSON.parse response.body
        expect(json["error"]).not_to eq nil
      end
    end
  end

  describe "PUT #update" do
    let(:category) { create(:category) }
    context "with valid params" do
      let(:new_attributes) { { { category: { name: "買い物" } }, format: :js } }
      before do
        new_attributes[:id] = category.id
        put :update, new_attributes, valid_session
      end

      it "updates the requested category" do
        category.reload
        expect(category.name).to eq "買い物"
      end

      it "return json of category" do
        json = JSON.parse response.body
        expect(json["name"]).to eq "買い物"
      end
    end

    context "with invalid params" do
      before do
        put :update, { { category: { color_id: nil } }, format: :js }, valid_session
      end
      it "return json error" do
        json = JSON.parse response.body
        expect(json["error"]).not_to eq nil
      end

      it "return status is 501" do
        expect(response.status).to eq 501
      end
    end
  end

  describe "DELETE #destroy" do
    let(:category) { create :category }
    before do
      delete :destroy, { id: category.id }, valid_session
    end
    it "destroy category" do
      expect(Category.count).to eq 0
    end
  end
end
