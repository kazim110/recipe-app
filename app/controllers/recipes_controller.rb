class RecipesController < ApplicationController
  before_action :authenticate_user!
  helper_method :calculate_total_price
  before_action :set_recipe, only: %i[show edit update destroy new_food create_food]

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc).includes(:recipe_foods)
  end

  def show
    @recipe = Recipe.includes(:foods, :recipe_foods).find(params[:id])
  end

  def toggle_visibility
    @recipe.update(is_public: !@recipe.is_public)
    redirect_to @recipe, notice: 'Recipe visibility updated.'
  end

  def destroy
    if @recipe.user != current_user
      redirect_to @recipe, alert: 'You are not authorized to perform this action.'
      return
    end

    filtered_recipe_foods = RecipeFood.where(recipe_id: @recipe.id)
    filtered_recipe_foods.destroy_all
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /recipes or /recipes.json
  def index
    @current_user = current_user
    @recipes = Recipe.all
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully added.'
    else
      render :new
    end
  end

  def new_food
    @current_user = current_user
    if @recipe.user_id != current_user.id
      redirect_to recipe_url(@recipe), alert: 'You donot have the authority to modify that recipe!.'
    end
    @food = Food.new
  end

  def create_food
    # @food = Food.new(food_params)
    @food = @recipe.foods.new(food_params)
    @food.recipe_id = @recipe.id
    @food.user_id = @recipe.user_id

    respond_to do |format|
      if @food.save
        format.html { redirect_to food_url(@food), notice: 'Food was successfully added to the recipe.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :discription, :public, :user_id)
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id, :recipe_id)
  end
end
