FactoryGirl.define do
  factory :event do
    user_id 1
    google_calendar_id 1
    summary "MyString"
    sync_token "MyString"
    date "2016-07-09 23:46:39"
    description "MyString"
    status 1
  end
end
