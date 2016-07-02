FactoryGirl.define do
  factory :setting do
    start_week_day_id 1
    time_format_id 1
    factory :sunday_setting do
      start_week_day_id 1
    end
    factory :monday_setting do
      start_week_day_id 1
    end
    factory :other_format_setting do
      time_format_id 1
    end
  end
end
