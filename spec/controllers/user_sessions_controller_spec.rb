require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  let(:valid_session) { { user_id: 1 } }

  describe "GET #new" do
    it "render new" do
      get :new, {}
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }
    context "valid_params" do
      it "when email" do
        post :create, { user: { email_or_name: user.email, password: "testpass" } }
        expect(response).to redirect_to tasks_path
        expect(session[:user_id]).to eq(user.id)
      end

      it "when name" do
        post :create, { user: { email_or_name: user.name, password: "testpass" } }
        expect(response).to redirect_to tasks_path
        expect(session[:user_id]).to eq(user.id)
      end
    end
    context "invalid_params" do
      it "when email" do
        post :create, { user: { email_or_name: user.email + "a", password: "testpass" } }
        expect(response).to render_template :new
        expect(session[:user_id]).to be_falsey
      end

      it "when name" do
        post :create, { user: { email_or_name: user.name + "a", password: "testpass" } }
        expect(response).to render_template :new
        expect(session[:user_id]).to be_falsey
      end

      it "password" do
        post :create, { user: { email_or_name: user.name, password: "invalidpass" } }
        expect(response).to render_template :new
        expect(session[:user_id]).to be_falsey
      end
    end
  end

  describe "DELETE #destroy" do
    it "redirect new" do
      create(:user)
      delete :destroy, {}, valid_session
      expect(response).to redirect_to top_path
      expect(session[:user_id]).to be_falsey
    end
  end
end
