require 'rails_helper'

RSpec.describe 'foods/add', type: :view do
  before(:each) do
    assign(:food, Food.new)
    render
  end

  it 'displays the form to add a new food' do
    expect(rendered).to have_selector('h2', text: 'Add a new food')
    expect(rendered).to have_selector('form.foods-form[action="/foods"][method="post"]')
    expect(rendered).to have_selector('form input[type="text"][name="food[name]"]')
    expect(rendered).to have_selector('form input[type="submit"][value="Add new food"]')
  end
end
