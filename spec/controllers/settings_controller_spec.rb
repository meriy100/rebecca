require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  let(:valid_session) { { user_id: 1 } }
  let(:user) { create(:user) }
  before do
    user
  end
  describe "GET show" do
    context "render" do
      it "show" do
        get :show, {}, valid_session
      end
    end
  end
end
