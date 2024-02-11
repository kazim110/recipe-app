require 'rails_helper'

RSpec.describe 'Food management', type: :request do
  let(:user) do
    User.destroy_all
    User.create(name: 'Rubanza Mark', email: 'markrubanza10@gmail.com', password: '123456')
  end
  let(:food) do
    Food.destroy_all
    Food.create(name: 'rice', measurement_unit: 'gram', price: 15, quantity: 500, user:)
  end
  it 'test the response status of food page is ok' do
    user.confirm
    sign_in user
    get foods_path
    expect(response).to have_http_status(:ok)
  end
  it 'test the render function of food page' do
    user.confirm
    sign_in user
    get foods_path
    expect(response).to render_template(:index)
  end
  it 'test the content of food page' do
    user.confirm
    sign_in user
    get foods_path
    expect(response.body).to include('Foods')
  end
  it 'test the response status of food page is ok' do
    user.confirm
    sign_in user
    get food_path(food)
    expect(response).to have_http_status(:ok)
  end
  it 'test the render function of food page' do
    user.confirm
    sign_in user
    get food_path(food)
    expect(response).to render_template(:show)
  end
  it 'test the content of food show page' do
    user.confirm
    sign_in user
    get food_path(food)
    expect(response.body).to include('Price:')
  end
end
