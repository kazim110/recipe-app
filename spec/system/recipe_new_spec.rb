require 'rails_helper'
RSpec.describe 'Recipe index page Capybara integration test', type: :system do
  before :all do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
    @me = User.create(name: 'mohamed abd el mohsen saleh', email: 'mohamed20163858@gmail.com', password: 'momo123456')
    @me.confirm
    recipe1 = Recipe.create(name: 'pastsa', preparation_time: 15, cooking_time: 15,
                            description: 'very delicious recipe!', public: true, user: @me)
    food1 = Food.create(name: 'rice', measurement_unit: 'gram', price: 15, quantity: 500, user: @me)
    RecipeFood.create(recipe: recipe1, food: food1, quantity: 3)
  end
  after :all do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
  end
  it 'test creating new recipe' do
    sign_in @me
    visit new_recipe_path
    sleep(1)
    fill_in 'Name', with: 'well done meat'
    fill_in 'Preparation time', with: '15'
    fill_in 'Cooking time', with: '15'
    fill_in 'Description', with: 'put it in oven'
    check 'Public'
    click_button 'Create Recipe'
    visit root_path
    expect(page).to have_content('well done meat')
    visit public_recipes_path
    expect(page).to have_content('Well Done Meat')
  end
end
