FactoryGirl.define do
  factory :category do
    name "仕事"
    icon_id 1
    color_id 1
    factory :invaild_category do
      icon_id nil
    end
  end
end
