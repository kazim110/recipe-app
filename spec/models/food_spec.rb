require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  it 'is valid with valid attributes' do
    food = Food.new(
      name: 'Apple',
      user:,
      measurement_unit: 'gram',
      price: 15,
      quantity: 500
    )
    expect(food).to be_valid
  end

  it 'belongs to a user' do
    association = Food.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'has many recipe_foods' do
    association = Food.reflect_on_association(:recipe_foods)
    expect(association.macro).to eq(:has_many)
  end
end
