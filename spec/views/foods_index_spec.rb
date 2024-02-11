require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
  before do
    assign(:foods, [
             Food.create(name: 'Apple', measurement_unit: 'Piece', price: 1, quantity: 10),
             Food.create(name: 'Banana', measurement_unit: 'Bunch', price: 2, quantity: 5)
           ])
  end

  it 'displays the table headers' do
    render
    expect(rendered).to have_content('#')
    expect(rendered).to have_content('Name')
    expect(rendered).to have_content('Measurement unit')
    expect(rendered).to have_content('Unit price')
    expect(rendered).to have_content('Quantity')
    expect(rendered).to have_content('Show this food')
    expect(rendered).to have_content('Actions')
  end

  it 'displays the food data in the table' do
    render
    expect(rendered).to have_content('1')
    expect(rendered).to have_content('Apple')
    expect(rendered).to have_content('Piece')
    expect(rendered).to have_content('1')
    expect(rendered).to have_content('10')
    expect(rendered).to have_button('Delete')
  end

  it 'displays the "New food" link' do
    render
    expect(rendered).to have_link('New food', href: new_food_path)
  end
end
