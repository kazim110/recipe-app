require 'rails_helper'

RSpec.describe 'layouts/application', type: :view do
  before(:each) do
    allow(view).to receive(:user_signed_in?).and_return(false) # Simulating user not being signed in
    render
  end

  it 'displays the navigation bar' do
    expect(rendered).to have_selector('nav.navbar.navbar-expand-lg.bg-body-tertiar.navbar-dark.bg-primary')
    expect(rendered).to have_selector('.navbar-brand', text: 'Recipes App')
    expect(rendered).to have_selector('button.navbar-toggler[type="button"]')
    expect(rendered).to have_selector('div.collapse.navbar-collapse#navbarSupportedContent')
    expect(rendered).to have_selector('ul.navbar-nav')
    expect(rendered).to have_selector('.d-flex li.nav-item', text: 'Sign in')
    expect(rendered).to have_selector('.d-flex li.nav-item', text: 'Sign up')
  end

  it 'displays different navigation links when user is signed in' do
    allow(view).to receive(:user_signed_in?).and_return(true) # Simulating user being signed in
    render

    expect(rendered).to have_selector('.d-flex li.nav-item', text: 'Sign out')
    expect(rendered).to have_selector('.d-flex li.nav-item', text: 'Edit profile')
  end
end
