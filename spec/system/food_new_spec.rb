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
  it 'test creating new food' do
    sign_in @me
    visit new_food_path
    sleep(1)
    fill_in 'Name', with: 'orange'
    fill_in 'Measurement unit', with: 'gram'
    fill_in 'Price', with: '15'
    fill_in 'Quantity', with: '500'
    click_button 'Create Food'
    visit foods_path
    expect(page).to have_content('orange')
  end
end
