class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :carts
  validates :first_name, presence: true
  validates :first_name, length: { minimum: 2 }
  validates :email, presence: true
end
