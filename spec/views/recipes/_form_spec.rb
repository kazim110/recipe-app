require 'rails_helper'

RSpec.describe 'recipes/new', type: :view do
  let(:recipe) { Recipe.new }

  before do
    assign(:recipe, recipe)
  end

  it 'displays the form elements' do
    render

    expect(rendered).to have_selector('form')
    expect(rendered).to have_selector('input[type="text"][name="recipe[name]"]')
    expect(rendered).to have_selector('input[type="number"][name="recipe[preparation_time]"]')
    expect(rendered).to have_selector('input[type="number"][name="recipe[cooking_time]"]')
    expect(rendered).to have_selector('textarea[name="recipe[description]"]')
    expect(rendered).to have_selector('input[type="checkbox"][name="recipe[public]"]')
    expect(rendered).to have_selector('input[type="submit"]')
  end

  it 'displays error messages if recipe has errors' do
    recipe.errors.add(:name, "can't be blank")
    recipe.errors.add(:description, 'is too short')

    render

    expect(rendered).to have_selector('div', text: '2 errors prohibited this recipe from being saved')
    expect(rendered).to have_selector('ul > li', text: "Name can't be blank")
    expect(rendered).to have_selector('ul > li', text: 'Description is too short')
  end

  it 'does not display error messages if recipe has no errors' do
    render

    expect(rendered).not_to have_selector('div', text: 'prohibited this recipe from being saved')
    expect(rendered).not_to have_selector('ul > li')
  end
end
