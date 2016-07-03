FactoryGirl.define do
  factory :category do
    name "仕事"
    icon_id 1
    color_id 1
    factory :invaild_category do
      icon_id nil
    end
    factory :other_category do
      name "個人"
      icon_id 2
      color_id 2
    end
  end
end
