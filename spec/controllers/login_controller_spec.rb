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
    it "render index" do
      create(:user)
      get :logout, {}, valid_session
      expect(response).to redirect_to login_path
      expect(session[:user_id]).to be_falsey
    end
  end

end
