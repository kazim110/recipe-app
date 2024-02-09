class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipe_foods = current_user.recipe_foods.includes(:food, :recipe)
    @total_items = @recipe_foods.sum(:quantity)
    @total_price = @recipe_foods.sum { |item| item.quantity * item.food.price }

    if @recipe_foods.empty?
      flash.now[:alert] = "Your shopping list is empty."
    end
  end
end
