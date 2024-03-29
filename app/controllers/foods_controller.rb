class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[show edit update destroy]

  # GET /foods or /foods.json
  def index
    @foods = current_user.foods
  end

  # GET /foods/1 or /foods/1.json
  def show
    @recipe_foods = @food.recipe_foods.includes(:recipe)
  end

  # GET /foods/new
  def new
    @food = Food.new
  end

  # GET /foods/1/edit
  def edit; end

  # POST /foods or /foods.json
  def create
    # @food = Food.new(food_params)
    @current_user = current_user
    @food = @current_user.foods.new(food_params)
    @food.user_id = @current_user.id
    food_name_test = Food.find_by(name: @food.name, user_id: @food.user_id)
    if food_name_test
      redirect_to new_food_path, alert: 'couldnot create this food as its name is already exisiting in your food list'
    else
      respond_to do |format|
        if @food.save
          format.html { redirect_to food_url(@food), notice: 'Food was successfully created.' }
          format.json { render :show, status: :created, location: @food }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @food.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to food_url(@food), notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    filtered_recipe_foods = RecipeFood.find_by(food_id: @food.id)
    if filtered_recipe_foods
      redirect_to foods_url, alert: 'Cannot destroy this food cause it is contained in one of your recipes'
    else
      @food.destroy
      respond_to do |format|
        format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = current_user.foods.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
