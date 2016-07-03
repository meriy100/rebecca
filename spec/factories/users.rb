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
    factory :update_user do
      name "test_user2"
    end
    factory :password_update_user do
      password "testpass2"
    end
    factory :invalid_user do
      email "test.com"
    end
  end
end
