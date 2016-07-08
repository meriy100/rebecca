class Category < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions
  include CurrentUser

  belongs_to_active_hash :color
  belongs_to_active_hash :icon

  before_validation :set_sync_token

  validates :sync_token, presence: true, uniqueness: true
  validates :category_name, presence: true

  belongs_to :user
  has_many :tasks

  delegate :name, to: :category_color, prefix: true
  delegate :name, to: :category_icon, prefix: true

  scope :on_user, -> { where user: User.current_user }

  def set_sync_token
    self.sync_token = SecureRandom.uuid if sync_token.nil?
  end
end
