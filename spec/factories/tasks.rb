FactoryGirl.define do
  factory :task do
    user_id 1
    title "テストタスク1"
    is_done false
    weight 2
    deadline_at Time.zone.tomorrow
    factory :fail_task do
      deadline_at Time.zone.yesterday
    end
    factory :doned_task do
      is_done true
    end
    factory :sync_task do
      sync_token "aaaaaaaaaaaaaa"
      title "テストタスク2"
      is_done false
      updated_at Time.zone.now
      created_at Time.zone.now
    end
  end
end
