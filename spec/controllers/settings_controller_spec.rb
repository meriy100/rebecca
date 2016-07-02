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
  describe "PATCH update" do
    let(:setting) { create(:setting) }
    context "start_week_day" do
      it "is changed" do
        patch :update, { setting: { start_week_day_id: 2 } }, valid_session
        setting.reload
        expect(setting.start_week_day_id).to eq 2
      end
    end
    context "time_format" do
      it "is changed" do
        patch :update, { setting: { time_format_id: 2 } }, valid_session
        setting.reload
        expect(setting.time_format_id).to eq 2
      end
    end
  end
end
