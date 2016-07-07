require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { create :user }
  before do
    User.current_user = user
  end
  describe "category created" do
    context "with vaild attributes" do
      let(:category) { create :category }
      it "created" do
        category
        expect(Category.count).to eq 1
        expect(category.category_name).to eq "仕事"
      end
      it "user is current_user" do
        expect(category.user).to eq user
      end
    end
    context "with invaild attributes" do
      let(:category) { create :invalid_category }
      it "not created" do
        expect(Category.count).to eq 0
      end
    end
  end
  describe "icon" do
    let(:category) { create :category }
    context "get class" do
      it "get icon" do
      # icon_id = 1 が仕事のアイコンだとした時 別のやつに変えて大丈夫
        expect(category.icon_class).to eq "fa fa-briefcase"
      end
    end
  end
  describe "color" do
    let(:category) { create :category }
    context "get class" do
      it "get color" do
      # color_id = 1 が 赤だとしたとき 別のやつに変えて大丈夫
        expect(category.color_class).to eq "red"
      end
    end
  end
end
