FactoryGirl.define do
  factory :user do
    id 1
    name "test_user"
    email "test@test.com"
    password "testpass"
    factory :other_user do
      id 2
      name "test_user2"
      email "test2@test.com"
    end
  end
end
