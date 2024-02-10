class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe_food, only: %i[show edit update destroy]

  def index
    #     @recipe = Recipe.find(params[:recipe_id])
    #     redirect_to @recipe
    @recipe_foods = current_user.recipe_foods.includes(:food, :recipe)
    @total_items = @recipe_foods.sum(:quantity)
    @total_price = @recipe_foods.sum { |item| item.quantity * item.food.price }
  end

  # GET /recipe_foods/1 or /recipe_foods/1.json
  def show
    @recipe = Recipe.find(params[:recipe_id])
  end

  # GET /recipe_foods/new
  def new
    @recipe = Recipe.find(params[:recipe_id])
    if @recipe.user_id != current_user.id
      redirect_to recipe_url(@recipe), alert: 'You donot have the authority to modify that recipe!.'
    end
    @recipe_food = RecipeFood.new
  end

  # GET /recipe_foods/1/edit
  def edit
    @recipe = Recipe.find(params[:recipe_id])
  end

  # POST /recipe_foods or /recipe_foods.json
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = @recipe.id
    food_id_test = RecipeFood.find_by(recipe_id: @recipe_food.recipe_id, food_id: @recipe_food.food_id)
    if food_id_test
      redirect_to @recipe, alert: 'Recipe food ingredient already existed in your recipe food list!.'
    else
      respond_to do |format|
        if @recipe_food.save
          format.html { redirect_to @recipe, notice: 'Recipe food ingredient was successfully added.' }
          format.json { render :show, status: :created, location: @recipe_food }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /recipe_foods/1 or /recipe_foods/1.json
  def update
    @recipe = Recipe.find(params[:recipe_id])
    respond_to do |format|
      if @recipe_food.update(recipe_food_params)
        format.html { redirect_to @recipe, notice: 'Recipe food was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_foods/1 or /recipe_foods/1.json
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food.destroy

    respond_to do |format|
      format.html { redirect_to @recipe, notice: 'Recipe food ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
