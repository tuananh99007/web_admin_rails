class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }
  validates :price, presence: true, numericality: true
  belongs_to :category

end
