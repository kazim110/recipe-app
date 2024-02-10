require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  it 'is valid with valid attributes' do
    recipe = Recipe.new(
      name: 'Apple Pie',
      user:,
      preparation_time: 15,
      cooking_time: 15,
      description: 'very delicious recipe!',
      public: true
    )
    expect(recipe).to be_valid
  end

  it 'belongs to a user' do
    association = Recipe.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'has many recipe_foods' do
    association = Recipe.reflect_on_association(:recipe_foods)
    expect(association.macro).to eq(:has_many)
  end
end
