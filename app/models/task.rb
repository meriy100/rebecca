class Task < ActiveRecord::Base
  # belongs_to :user
  include CurrentUser
  acts_as_paranoid

end
