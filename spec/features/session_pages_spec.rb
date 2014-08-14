require 'spec_helper'

describe "Session pages" do
  subject{ page }
  before do
    visit signin_path
    @admin = FactoryGirl.create(:admin)
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Sign in"
  end
  it{ should have_selector("div.success") }
end

