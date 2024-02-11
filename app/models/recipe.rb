class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods
  validates :name, presence: true, length: { maximum: 50 }
  # validates :measurement_unit, presence: true
  # validates :name, :preparation_time, :cooking_time, :discription, presence: true
  # validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
