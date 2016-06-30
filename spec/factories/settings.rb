FactoryGirl.define do
  factory :setting do
    start_week_day_id 1
    time_format_id 1
    start_page 1
    factory :sunday do
      start_week_day_id 1
    end
  end
end
