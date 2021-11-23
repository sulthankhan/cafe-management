class MenuItem < ActiveRecord::Base
  belongs_to :menu
  validates :name, presence: true
  validates :price, presence: true
  validates :price, numericality: true
end
