require 'spec_helper'

describe "Authentication" do

  subject { page }  

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
    #can can permission
  end

  describe "signin" do
    
    before { visit signin_path }
    #testing that invalid information is error-messaged
    describe "with invalid information" do

      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.error') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.error') }
      end

    end

    describe "with valid information" do

      let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_title(user.name) }
      it { should have_link("#{user.name}",     href: user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

    end

  end

end