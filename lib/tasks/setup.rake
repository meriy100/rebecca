namespace :settings do
  desc "User setting init"
  task :init do
    User.all.each do |u|
      if u.setting.blank?
        u.setting = Setting.new
        u.setting.save!
      end
    end
  end
end

namespace :categories do
  desc "User setting init"
  task :init do
    User.all.each do |user|
      next if user.categories.present?
      category = user.categories.create name: "勉強", color_id: 1, icon_id: 1
      user.tasks.each do |tasuk|
        tasuk.category = category
        tasuk.update
      end
    end
  end
end
