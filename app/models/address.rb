class Address < ApplicationRecord
  belongs_to :user
  validates :country, presence: true
  validates :city, presence: true
end
