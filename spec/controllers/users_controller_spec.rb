require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_session) { { user_id: 1 } }

  describe "GET #new" do
    before do
      get :new, {}
    end
    it "render sign_up" do
      expect(response).to render_template :new
    end
    it "render sign_up" do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      let(:attributes) { attributes_for(:user) }
      before do
        post :create, user: attributes
      end
      it "redirect_to tasks_path" do
        expect(response).to redirect_to tasks_path
      end
      it "created user" do
        expect(User.count).to eq 1
      end
      it "have user id session" do
        expect(session[:user_id]).to eq User.first.id
      end
    end
    context "with invalid attributes" do
      let(:attributes) { attributes_for(:invalid_user) }
      before do
        post :create, user: attributes
      end
      it "render sign_up" do
        expect(response).to render_template :new
      end
      it "un created user" do
        expect(User.count).to eq 0
      end
      it "dont have user id session" do
        expect(session[:user_id]).to be_falsey
      end
    end
  end

  describe "PATCH #update" do
    let(:user) { create(:user) }
    before { user }
    context "with valid attributes" do
      let(:attributes) { attributes_for(:update_user) }
      before do
        patch :update, { user: attributes }, valid_session
      end
      it "return user json" do
        json = JSON.parse response.body
        expect(json["name"]).not_to eq user.name
        expect(json["name"]).to eq build(:update_user).name
      end
      it "return user json expect password_digest" do
        json = JSON.parse response.body
        expect(json["password_digest"]).not_to eq build(:update_user).password_digest
      end
      it "update user attribute" do
        user.reload
        expect(user.name).to eq build(:update_user).name
      end
    end
    context "with invalid attributes" do
      let(:attributes) { attributes_for(:invalid_user) }
      before do
        patch :update, { user: attributes }, valid_session
      end
      it "return user error json" do
        json = JSON.parse response.body
        expect(json["error"]["email"]).to eq ["は不正な値です"]
      end
    end
  end
end
