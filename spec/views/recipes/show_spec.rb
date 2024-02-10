require 'rails_helper'

RSpec.describe 'recipes/show', type: :view do
  let(:recipe) { Recipe.new(id: 1, name: 'Pasta', user_id: 1) }
  let(:food) { Food.new(id: 1, name: 'Tomato', price: 2.99, quantity: 2, measurement_unit: 'pieces') }

  before do
    assign(:recipe, recipe)
    assign(:food, food)
    allow(view).to receive(:current_user).and_return(nil)
  end

  context 'when current user is present and recipe belongs to the user' do
    before do
      user = instance_double('User', id: 1)
      allow(view).to receive(:current_user).and_return(user)
    end

    it 'displays edit, destroy, and back links' do
      render

      expect(rendered).to have_link('Edit this recipe', href: edit_recipe_path(recipe))
      expect(rendered).to have_link('Back to recipes', href: recipes_path)
      expect(rendered).to have_button('Destroy this recipe')
    end

    it 'displays the buttons group with correct links' do
      render

      expect(rendered).to have_link('Generate shopping list', href: general_shopping_list_path)
      expect(rendered).to have_link('Add ingredient', href: new_recipe_recipe_food_url(recipe))
    end
  end

  context 'when current user is not present' do
    it 'displays the back link' do
      render

      expect(rendered).to have_link('Back to recipes', href: recipes_path)
    end
  end
end
