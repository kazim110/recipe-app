class RecipeFood < ApplicationRecord
  belongs_to :food
  belongs_to :recipe

  belongs_to :user
end
