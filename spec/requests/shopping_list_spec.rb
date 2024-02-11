require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  let(:user) do
    User.destroy_all
    User.create(name: 'mohamed abd el mohsen saleh', email: 'mohamed20163858@gmail.com', password: 'momo123456')
  end
  it 'test the response status of shopping list page is ok' do
    user.confirm
    sign_in user
    get general_shopping_list_path
    expect(response).to have_http_status(:ok)
  end
  it 'test the render function of shopping list  page' do
    user.confirm
    sign_in user
    get general_shopping_list_path
    expect(response).to render_template(:index)
  end
end
