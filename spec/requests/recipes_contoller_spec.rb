require 'rails_helper'

RSpec.describe 'Recipe management', type: :request do
  let(:user) do
    User.destroy_all
    User.create(name: 'mohamed abd el mohsen saleh', email: 'mohamed20163858@gmail.com', password: 'momo123456')
  end
  let(:recipe) do
    Recipe.destroy_all
    Recipe.create(name: 'pastsa', preparation_time: 15, cooking_time: 15, description: 'very delicious recipe!',
                  public: true, user:)
  end
  it 'test the response status of recipe page is ok' do
    user.confirm
    sign_in user
    get root_path
    expect(response).to have_http_status(:ok)
  end
  it 'test the render function of recipe page' do
    user.confirm
    sign_in user
    get root_path
    expect(response).to render_template(:index)
  end
  it 'test the content of recipe page' do
    user.confirm
    sign_in user
    get root_path
    expect(response.body).to include('My Recipes')
  end
  it 'test the response status of home page is ok' do
    user.confirm
    sign_in user
    get recipe_path(recipe)
    expect(response).to have_http_status(:ok)
  end
  it 'test the render function of home page' do
    user.confirm
    sign_in user
    get recipe_path(recipe)
    expect(response).to render_template(:show)
  end
  it 'test the content of recipe show page' do
    user.confirm
    sign_in user
    get recipe_path(recipe)
    expect(response.body).to include('Preparation time')
  end
end
