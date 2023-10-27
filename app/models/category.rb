class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255, too_long: "is too long (maximum is 255 characters)" }
  has_many :products, dependent: :destroy

end
