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
        tasks = days_tasks(today, (-1..7))
        # 現在日を日曜に固定
        Timecop.freeze(today)
        expect(Task.on_user.weeklys.count).to eq 7
        expect(Task.on_user.weeklys).not_to include tasks.first
        expect(Task.on_user.weeklys).not_to include tasks.last
      end
      it "when monday" do
        today = Date.today.prev_week(:monday)
        tasks = days_tasks(today, (-2..6))
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
        tasks = days_tasks(today, (-1..7))
        # 現在日を月曜に固定
        Timecop.freeze(today)
        expect(Task.on_user.weeklys.count).to eq 7
        expect(Task.on_user.weeklys).not_to include tasks.first
        expect(Task.on_user.weeklys).not_to include tasks.last
      end
    end
  end
  describe "time_format" do
    let(:user) { create(:user) }
    before do
      User.current_user = user
    end
    it "task.deadline_at_to_s is format" do
      Timecop.freeze(Time.zone.now.sunday)
      task = create(:task, deadline_at: Time.zone.today.since(10.day))
      user.setting.update time_format: TimeFormat.find_by(show: "1/1(月)")
      expect(task.deadline_at_to_s).to eq task.deadline_at.strftime("%-m/%-d(%a)")
    end
  end
end

def days_tasks today, range
  Timecop.freeze(Time.zone.today.ago(1.month))
  ((today + range.first) .. (today + range.last)).map do |day|
    create(:task, deadline_at: day)
  end
end
