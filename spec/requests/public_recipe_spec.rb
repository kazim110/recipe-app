require 'rails_helper'

RSpec.describe 'PublicRecipes', type: :request do
  let(:user) do
    User.destroy_all
    User.create(name: 'Rubanza Mark', email: 'markrubanza10@gmail.com', password: '123456')
  end
  it 'test the response status of public recipes page is ok' do
    user.confirm
    sign_in user
    get public_recipes_path
    expect(response).to have_http_status(:ok)
  end
  it 'test the render function of public recipes page' do
    user.confirm
    sign_in user
    get public_recipes_path
    expect(response).to render_template(:index)
  end
end
