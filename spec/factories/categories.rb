FactoryGirl.define do
  factory :category do
    name "仕事"
    factory :invaild_category do
      icon_id nil
    end
  end
end
