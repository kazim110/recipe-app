require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:recipe) do
    Recipe.new(
      name: 'Apple Cake',
      user:,
      preparation_time: 15,
      cooking_time: 15,
      discription: 'very delicious recipe!',
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
    it 'is valid with valid attributes' do
      recipe = Recipe.new(
        recipe:,
      )
      expect(recipe).to be_valid
    end

    it "is not valid without a name" do
      expect(recipe).not_to be_valid
      expect(recipe.errors[:name]).to include("can't be blank")
    end

    it "is not valid without a user" do
      expect(recipe).not_to be_valid
      expect(recipe.errors[:user]).to include("must exist")
    end

    it "is not valid with a negative preparation time" do
      expect(recipe).not_to be_valid
      expect(recipe.errors[:preparation_time]).to include("must be greater than or equal to 0")
    end

    it "is not valid with a negative cooking time" do
      expect(recipe).not_to be_valid
      expect(recipe.errors[:cooking_time]).to include("must be greater than or equal to 0")
    end

    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
    
    it "has many recipe_foods" do
      association = described_class.reflect_on_association(:recipe_foods)
      expect(association.macro).to eq :has_many
    end
    # Add more association tests as needed
  end
end
