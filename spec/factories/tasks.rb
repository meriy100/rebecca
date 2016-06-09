FactoryGirl.define do
  factory :task do
    user_id 1
    title "テストタスク1"
    weight 2
    deadline_at Time.zone.tomorrow
    factory :fail_task do
      deadline_at Time.zone.yesterday
    end
    factory :doned_task do
      is_done true
    end
  end
end
