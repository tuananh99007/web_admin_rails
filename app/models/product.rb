class Product < ApplicationRecord
  belongs_to :category

  def self.category_name
      category = @categories.find { |cat| cat.id == category_id }
      category.present? ? category.name : "Unknown Category"
  end
end
