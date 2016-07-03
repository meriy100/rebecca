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
