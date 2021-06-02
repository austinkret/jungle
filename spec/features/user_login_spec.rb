require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create first_name: 'Thor', last_name: 'Odinson', email: 'thor@asgardnet.com', password: 'mjolnir', password_confirmation: 'mjolnir'
  end

  scenario "User can login using email and password matching their existing credentials" do
    # ACT
    visit root_path

    click_link("Login")

    
    fill_in 'email', with: 'thor@asgardnet.com'
    fill_in 'password', with: 'mjolnir'
    click_on 'Submit'

    expect(page).to have_content('Thor')
    # DEBUG
    save_screenshot 'user-login.png'
  end
end
