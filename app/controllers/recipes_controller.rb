class RecipesController < ApplicationController
  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc).includes(:user)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def toggle_visibility
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      @recipe.update(public: !@recipe.public)
      redirect_to @recipe, notice: 'Visibility updated successfully.'
    else
      redirect_to @recipe, alert: 'You are not authorized to perform this action.'
    end
  end

  def destroy
    if @recipe.user == current_user
      @recipe.destroy
      redirect_to recipes_url, notice: 'Recipe was successfully destroyed.'
    else
      redirect_to @recipe, alert: 'You are not authorized to perform this action.'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
