class Category < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  include CurrentUser

  belongs_to_active_hash :category_color
  belongs_to_active_hash :category_icon

  before_validation :set_sync_token

  validates :sync_token, presence: true, uniqueness: true
  validates :category_name, presence: true

  delegate :color_id, to: :category_color
  delegate :icon_id, to: :category_icon

  scope :on_user, -> { where user: User.current_user }

  def set_sync_token
    self.sync_token = SecureRandom.uuid if sync_token.nil?
  end
end
