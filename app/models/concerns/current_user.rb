module CurrentUser
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    before_create :set_current_user
  end

  def current_user_id
    User.current_user.try(:id)
  end

  def set_current_user
    self.user_id = current_user_id if current_user_id.present?
    true
  end

  def set_updated_user
    self.updated_user_id = current_user_id if current_user_id.present?
    true
  end
end
