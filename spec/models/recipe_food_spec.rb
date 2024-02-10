require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:recipe) do
    Recipe.new(
      name: 'Apple Cake',
      user:,
      preparation_time: 15,
      cooking_time: 15,
      description: 'very delicious recipe!',
      public: true
    )
  end
  let(:food) do
    Food.new(
      name: 'Orange',
      user:,
      measurement_unit: 'gram',
      price: 15,
      quantity: 500
    )
  end

  it 'is valid with valid attributes' do
    recipe_food = RecipeFood.new(
      recipe:,
      food:,
      quantity: 15
    )
    expect(recipe_food).to be_valid
  end

  it 'belongs to a recipe' do
    association = RecipeFood.reflect_on_association(:recipe)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'belongs to a food' do
    association = RecipeFood.reflect_on_association(:food)
    expect(association.macro).to eq(:belongs_to)
  end
end
