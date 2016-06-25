require 'rails_helper'


RSpec.describe LoginController, type: :controller do

  let(:valid_attributes) {
  }

  let(:invalid_attributes) {
  }
  let(:valid_session) { { user_id: 1 } }

  describe "GET #index" do
    it "render index" do
      get :index, {}
      expect(response).to render_template :index
    end
  end

  describe "POST #login" do
    let(:user) { create(:user) }
    context "valid_params" do
      it "when email" do
        post :login, { email_or_name: user.email, password: "testpass" }
        expect(response).to redirect_to top_path
        expect(session[:user_id]).to eq(user.id)
      end

      it "when name" do
        post :login, { email_or_name: user.name, password: "testpass" }
        expect(response).to redirect_to top_path
        expect(session[:user_id]).to eq(user.id)
      end
    end
    context "invalid_params" do
      it "when email" do
        post :login, { email_or_name: user.email + "a", password: "testpass" }
        expect(response).to render_template :index
        expect(session[:user_id]).to be_falsey
      end

      it "when name" do
        post :login, { email_or_name: user.name + "a", password: "testpass" }
        expect(response).to render_template :index
        expect(session[:user_id]).to be_falsey
      end

      it "password" do
        post :login, { email_or_name: user.name, password: "invalidpass" }
        expect(response).to render_template :index
        expect(session[:user_id]).to be_falsey
      end
    end
  end

  describe "GET #logout" do
    it "redirect login_path" do
      create(:user)
      get :logout, {}, valid_session
      expect(response).to redirect_to login_path
      expect(session[:user_id]).to be_falsey
    end
  end

  describe "GET #sign_up" do
    it "render sign_up" do
      get :sign_up, {}
      expect(response).to render_template :sign_up
    end
    it "render sign_up" do
      get :sign_up, {}
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create_user" do
    context "with valid attributes" do
      let(:attributes) { attributes_for(:user) }
      before do
        post :create_user, {attributes}
      end
      it "redirect_to top_path" do
        expect(response).to redirect_to top_path
      end
    end
  end

end
