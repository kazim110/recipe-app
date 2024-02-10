require 'rails_helper'
RSpec.describe 'Recipe index page Capybara integration test', type: :system do
  before :all do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
    @me = User.create(name: 'mohamed abd el mohsen saleh', email: 'mohamed20163858@gmail.com', password: 'momo123456')
    @me.confirm
    @recipe1 = Recipe.create(name: 'pastsa', preparation_time: 15, cooking_time: 15,
                             description: 'very delicious recipe!', public: true, user: @me)
    @food1 = Food.create(name: 'rice', measurement_unit: 'gram', price: 15, quantity: 500, user: @me)
    @food2 = Food.create(name: 'dates', measurement_unit: 'gram', price: 20, quantity: 1000, user: @me)
    RecipeFood.create(recipe: @recipe1, food: @food1, quantity: 3)
  end
  after :all do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
  end
  it 'test removing the assoiated food to the recipe' do
    sign_in @me
    visit recipe_path(@recipe1)
    sleep(1)
    click_button 'Remove'
    expect(page).to_not have_content(@food1.measurement_unit)
  end
  it 'test modifying the assoiated food to the recipe' do
    sign_in @me
    visit recipe_path(@recipe1)
    sleep(1)
    click_link 'Modify'
    fill_in 'Quantity', with: '1'
    click_button 'Update Recipe food'
    expect(page).to have_content(@food1.quantity)
  end
  it 'test adding new ingredient to the recipe' do
    sign_in @me
    visit recipe_path(@recipe1)
    sleep(1)
    click_link 'Add ingredient'
    fill_in 'Quantity', with: '2'
    select @food2.name, from: 'Food'
    click_button 'Create Recipe food'
    expect(page).to have_content(@food2.name)
  end
end
