class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]

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
      
      respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
    redirect_to @recipe, alert: 'You are not authorized to perform this action.'
  end

  # GET /recipes or /recipes.json
  def index
    @current_user = current_user
    @recipes = @current_user.recipes
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @current_user = current_user
    @recipe = @current_user.recipes.new(recipe_params)
    @recipe.user_id = @current_user.id
    # @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
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
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
  end
end
