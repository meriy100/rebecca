require 'rails_helper'

RSpec.describe Setting, type: :model do
  describe "setting create on user create" do
    let(:user) { create(:user) }
    it "create setting" do
      expect(user.setting).to be_persisted
      expect(Setting.count).to eq 1
    end
    context "value is default" do
      it "for start_week_day_id" do
        expect(user.setting.start_week_day_id).to eq 1
      end
      it "for time_format_id" do
        expect(user.setting.time_format_id).to eq 1
      end
      it "for start_page" do
        expect(user.setting.start_page).to eq 1
      end
    end
  end
  describe "start_week_day" do
    let(:user) { create(:user) }
    before do
      User.current_user = user
    end
    context "is sunday" do
      before do
        user.setting.update start_week_day: StartWeekDay.find_by(week: :sun)
      end
      it "when sunday" do
        today = Date.today.prev_week(:sunday)
        Timecop.freeze(Time.zone.today.ago(1.month))
        tasks = ((today - 1) .. (today + 7)).map do |day|
          create(:task, deadline_at: day)
        end
        # 現在日を日曜に固定
        Timecop.freeze(today)
        expect(Task.on_user.weeklys.count).to eq 7
        expect(Task.on_user.weeklys).not_to include tasks.first
        expect(Task.on_user.weeklys).not_to include tasks.last
      end
      it "when monday" do
        today = Date.today.prev_week(:monday)
        Timecop.freeze(Time.zone.today.ago(1.month))
        tasks = ((today - 2) .. (today + 6)).map do |day|
          create(:task, deadline_at: day)
        end
        # 現在日を月曜に固定
        Timecop.freeze(today)
        expect(Task.on_user.weeklys.count).to eq 7
        expect(Task.on_user.weeklys).not_to include tasks.first
        expect(Task.on_user.weeklys).not_to include tasks.last
      end
    end
    context "is monday" do
      before do
        user.setting.update start_week_day: StartWeekDay.find_by(week: :mon)
      end
      it "when monday" do
        today = Date.today.prev_week(:monday)
        Timecop.freeze(Time.zone.today.ago(1.month))
        # 日 月 火 ... 土 日
        tasks = ((today - 1) .. (today + 7)).map do |day|
          create(:task, deadline_at: day)
        end
        # 現在日を月曜に固定
        Timecop.freeze(today)
        expect(Task.on_user.weeklys.count).to eq 7
        expect(Task.on_user.weeklys).not_to include tasks.first
        expect(Task.on_user.weeklys).not_to include tasks.last
      end
    end
  end
end
