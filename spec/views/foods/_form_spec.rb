require 'rails_helper'

RSpec.describe 'foods/new', type: :view do
  before(:each) do
    assign(:food, Food.new)
    render
  end

  it 'displays the form' do
    expect(rendered).to have_selector('form')
    expect(rendered).to have_selector('form input[type="text"][name="food[name]"]')
    expect(rendered).to have_selector('form input[type="text"][name="food[measurement_unit]"]')
    expect(rendered).to have_selector('form input[type="number"][name="food[price]"]')
    expect(rendered).to have_selector('form input[type="number"][name="food[quantity]"]')
    expect(rendered).to have_selector('form input[type="submit"]')
  end

  it 'displays errors if any' do
    food = Food.new
    food.errors.add(:name, "can't be blank")
    food.errors.add(:price, 'must be a positive number')
    assign(:food, food)
    render

    expect(rendered).to have_selector('div', text: /2 errors prohibited this food from being saved/)
    expect(rendered).to have_selector('div', text: 'Name can\'t be blank')
    expect(rendered).to have_selector('div', text: 'Price must be a positive number')
  end
end
