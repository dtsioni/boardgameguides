#user pages
require 'spec_helper'

describe "User pages" do

  subject {page}  

  describe "profile page" do
    
    before do      
      #sign in
      visit signin_path

      @admin = FactoryGirl.create(:admin)

      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password

      click_button "Sign in"

      visit root_path
      #visit new user page
      @user = FactoryGirl.create(:user)
      visit user_path(@user)

    end

    it { should have_content(@user.name) }
    it { should have_title(@user.name) }
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
        it { should_not have_selector('a#sign_up_home')}
        it { should_not have_selector('a#sign_in_home')}
        describe "followed by signout" do

          before do
            click_link('Account')
            click_link('Sign out')
          end

          it{should have_selector('a#sign_up_home')}
          it{should have_selector('a#sign_in_home')}          
        end

      end      

    end
    
  end
  
  describe "edit" do

    before do
      #sign in as admin
      visit signin_path
      @admin = FactoryGirl.create(:admin)
      fill_in "Email", with: @admin.email
      fill_in "Password", with: @admin.password
      click_button "Sign in"
      #example user to edit
      @user = FactoryGirl.create(:user)
    end

    describe "when changing user name" do
      
      describe "with invalid information" do
        before do
          @first = FactoryGirl.create(:user)
          @second = FactoryGirl.create(:user)
          visit edit_user_path(@second)
          fill_in "Name", with: @first.name
          fill_in "Email", with: @first.email
          click_button "Submit"
        end

        it{ should have_selector("div.error") }
        describe "after visiting another page" do
          before{ visit root_path }
          it{ should_not have_selector('div.error') }
        end
        
      end
        
      
      describe "with valid information" do
        before do
          
          @name_changed = "#{@user.name}x"
          @email_changed = "x#{@user.email}"
          visit edit_user_path(@user)
          fill_in "Name", with: @name_changed
          fill_in "Email", with: @email_changed

        end
        it { should have_content("#{@user.name}") }
        it "should change name" do
          expect{ click_button "Submit" 
            @user.reload}.to change(@user, :name)
        end
        it "should change email" do
          expect{ click_button "Submit" 
            @user.reload}.to change(@user, :email)
        end
        describe "on success" do
          before{ click_button "Submit" }
          it{ should have_selector("div.success") }
          describe "after visiting another page" do
            before{ visit root_path }
            it{ should_not have_selector('div.success') }
          end
        end
      end


    end

  end
    


  describe "control panel" do  

    before do
      #create example user
      @user = FactoryGirl.create :user
      #sign in as admin
      visit signin_path
      admin = FactoryGirl.create(:admin)
      fill_in "Email", with: admin.email
      fill_in "Password", with: admin.password
      click_button "Sign in"                  
      visit users_path
    end  

    describe "when changing user role" do
      before{ select "Moderator", from: "role_select_#{@user.id}" }      
      it "should change the user role" do
        expect { click_button "update_role_#{@user.id}"
                  #need to reload information
                  @user.reload }.to change(@user, :role)
      end
    end
  end        

  describe "when user is signed in" do

    before do

      visit signin_path

      @user = FactoryGirl.create(:user)

      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password

      click_button "Sign in"

      visit root_path

    end

    it { should have_selector("li#add_game") }

    describe "as admin" do

      before do

        visit signin_path

        @admin = FactoryGirl.create(:admin)

        fill_in "Email", with: @admin.email
        fill_in "Password", with: @admin.password

        click_button "Sign in"

        visit root_path

      end

      describe "user page" do

        before do

          @user2 = FactoryGirl.create(:user)

          visit( user_path(@user2) )

        end

        it {should have_content(@user2.role.humanize)}
        
      end

      describe "see control panel" do

        before{visit root_path}

        it{should have_selector("li#admin_panel")}

      end

      describe "show game page" do

        before do
          @game = FactoryGirl.create(:game)
          @ticket = FactoryGirl.create(:ticket)
          @game.tickets << @ticket
          visit game_path(@game)
        end
        it{ should have_selector("a#add_request") }
        it{ should have_content("#{@ticket.name}") }

      end

    end

  end

  

end