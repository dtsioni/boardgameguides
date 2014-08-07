#user pages
require 'spec_helper'

describe "User pages" do

  subject {page}  

  describe "profile page" do

    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user)}

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end  

  describe "signup page" do

    before {visit signup_path}
    it {should have_content('Sign up')}
    it {should have_title(full_title('Sign up'))}
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Submit" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"        
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }        
        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.success', text: 'Welcome!') }

        describe "followed by signout" do

          before do
            click_link('Account')
            click_link('Sign out')
          end

          it { should have_link('Sign in') }          
        end

      end      

    end
    
  end

  describe "home page" do
    
    describe "when user is signed out"
      before{visit root_path}
      describe "doesn't see sign in link"
        it{should have_selector('a#sign_up_home')}
        it{should have_selector('a#sign_in_home')}
    describe "when user is signed in" do
      describe "as admin" do
        before do
          visit signin_path
          admin = FactoryGirl.create(:admin)
          current_user = admin
          fill_in "Email", with: admin.email
          fill_in "Password", with: admin.password
          click_button "Sign in"     
        end

        describe "should see control panel" do
          before{visit root_path}
          it{should have_selector("li#admin_panel")}
        end

      end
    end

  end  

end