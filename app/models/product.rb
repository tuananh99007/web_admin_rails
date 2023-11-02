class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }
  validates :name, presence: true, uniqueness: true
  belongs_to :category

  def self.category_name
      category = @categories.find { |cat| cat.id == category_id }
      category.present? ? category.name : "Unknown Category"
  end
end
