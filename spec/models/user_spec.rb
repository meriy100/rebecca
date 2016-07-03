require 'rails_helper'

RSpec.describe User, type: :model do
  after do
    Timecop.return
  end
  describe "when create" do
    let(:attributes) { attributes_for(:user) }
    context "with vaild attributes" do
      it "created user" do
        User.create(attributes)
        expect(User.count).to eq 1
      end
    end
    context "with invaild attributes" do
      it "name empty" do
        attributes[:name] = ''
        User.create(attributes)
        expect(User.count).to eq 0
      end
      it "email empty" do
        attributes[:email] = ''
        User.create(attributes)
        expect(User.count).to eq 0
      end
      it "email isnt valid" do
        attributes[:email] = "test.com"
        User.create(attributes)
        expect(User.count).to eq 0
      end
    end
    context "un uniqe attribute" do
      let(:user) { create(:other_user) }
      it "name" do
        attributes[:name] = user.name
        User.create(attributes)
        expect(User.count).to eq 1
      end
      it "email" do
        attributes[:email] = user.email
        User.create(attributes)
        expect(User.count).to eq 1
      end
    end
  end

  describe "current_user" do
    it "current_user" do
      User.current_user = user = create(:user)
      expect(User.current_user).to eq user
    end
  end

  describe "email?" do
    it "vaild string" do
      expect(User.email?("test@test.com")).to be_truthy
    end
    it "invaild string" do
      expect(User.email?("test@testcom")).to be_falsey
    end
  end

  describe "task_updated_at" do
    let(:user) { create(:user) }
    it "get last task_updated_at" do
      User.current_user = user
      tasks = create_list(:task, 5)
      Timecop.freeze(Time.zone.tomorrow)
      tasks.third.done
      expect(user.task_updated_at).to eq Task.third.updated_at
      expect(user.task_updated_at).not_to eq Task.first.updated_at
    end
  end
end
