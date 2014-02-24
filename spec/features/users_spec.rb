require 'spec_helper'

feature "Visitor signs up" do
  scenario "with valid email" do
    sign_up_with Faker::Internet.email
    expect(page).to_not have_text("login")
  end

  scenario "with invalid email" do
    sign_up_with "invalid_email"
    expect(page).to have_text("login")
  end

  def sign_up_with(email)
    visit '/'
    fill_in 'Email', with: email
    click_button 'Get Started'
  end
end