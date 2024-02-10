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
  it 'test seeing the landing page title' do
    sign_in @me
    visit root_path
    sleep(1)
    expect(page).to have_content('My Recipes')
  end
  it 'test seeing the Recipe name' do
    sign_in @me
    visit root_path
    sleep(1)
    expect(page).to have_content('pastsa')
  end

  it 'test seeing the Recipe remove button' do
    sign_in @me
    visit root_path
    sleep(1)
    expect(page).to have_content('Remove')
  end
  it 'test deleting the Recipe' do
    sign_in @me
    visit root_path
    sleep(1)
    page.find_all('button')[0].click
    expect(page).to_not have_content('pastsa')
  end

  it 'test clicking new recipe link' do
    sign_in @me
    visit root_path
    sleep(1)
    click_link 'New recipe'
    expect(page).to have_current_path('/recipes/new')
  end
end
