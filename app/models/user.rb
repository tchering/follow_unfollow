class User < ApplicationRecord
  before_save :set_default_role

  # after_initialize :build_default_address, if: :new_record?
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validate :must_have_at_least_one_address
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true, reject_if: lambda { |attributes| attributes["country"].blank? || attributes["city"].blank? }

  #! You can use both reject_if and validations to achieve robust data handling. reject_if can prevent the creation of associated records with incomplete data, and validations can ensure that any created records meet the required criteria.

  has_secure_password

  # relationship association
  has_many :active_relation, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relation, source: :followed

  has_many :passive_relation, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relation, source: :follower

  # has_many :initiated_follows, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # has_many :followed_users, through: :initiated_follows, source: :followed

  # has_many :received_follows, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # has_many :followers, through: :received_follows, source: :follower
  def follow(other_user)
    self.followings << other_user
  end

  def unfollow(other_user)
    self.followings.delete(other_user)
  end

  private

  def must_have_at_least_one_address
    errors.add("You must have at least one address") if addresses.empty?
  end

  def is_admin?
    self.role = "admin"
  end

  def is_user?
    self.role = "user"
  end

  private

  def must_have_at_least_one_address
    errors.add(:addresses, "You must have at least one address") if addresses.empty?
  end

  def set_default_role
    self.role ||= "user"
  end
end
