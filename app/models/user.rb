# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  password_digest :string(255)
#  email           :string(255)
#  deleted_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessor :email_or_name
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 },
                    uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, on: :create
  before_create :set_setting
  has_secure_password
  has_many :tasks
  has_one :setting
  acts_as_paranoid

  def self.is_email?(string)
    string =~ VALID_EMAIL_REGEX
  end

  def task_updated_at
    tasks.max_by(&:updated_at).updated_at
  end

  # TODO
  # current_user_id にすべき
  def self.current_user=(user)
    Thread.current[:user_id] = user.id
  end

  def self.current_user
    User.find_by id: Thread.current[:user_id]
  end

  def self.reset_current_user
    Thread.current[:user_id] = nil
  end

  private

  def set_setting
    self.setting = Setting.new
  end
end
