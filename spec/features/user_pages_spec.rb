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

          it{should have_content("Sign up")}
          it{should have_content("Sign in")}          
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
    it { should have_selector("li#show_games") }
    it { should have_selector("li#show_tickets")}
    #icons
    it { should have_selector("span.glyphicon.glyphicon-home") }
    it { should have_selector("span.glyphicon.glyphicon-user") }
    it { should have_selector("span.glyphicon.glyphicon-pencil") }
    it { should have_selector("span.glyphicon.glyphicon-folder-open")}
    it { should have_selector("span.glyphicon.glyphicon-cog") }
    it { should have_selector("span.glyphicon.glyphicon-tower") }
    it { should have_selector("span.glyphicon.glyphicon-tag") }
    it { should have_selector("span.glyphicon.glyphicon-log-out") }

    describe "show page" do
      before{ visit user_path(@user) }
      it{ should have_content("Tickets") }
      it{ should have_content("Guides") }
    end

    describe "as admin" do
      before do
        visit signin_path
        @admin = FactoryGirl.create(:admin)
        fill_in "Email", with: @admin.email
        fill_in "Password", with: @admin.password
        click_button "Sign in"
        visit root_path
      end
      it{ should have_selector("span.glyphicon.glyphicon-wrench")}
      describe "user page" do
        before do
          @user2 = FactoryGirl.create(:user)
          visit( user_path(@user2) )
        end
        it { should have_content(@user2.role.humanize) }
      end
      describe "see control panel" do
        before{visit control_path}
        it{should have_selector("li#admin_panel")}
        it{ should have_content("Users") }
        it{ should have_content("Guides") }
        it{ should have_content("Tickets") }
        it{ should have_content("Games") }
      end
      describe "show game page" do
        before do
          @game = FactoryGirl.create(:game)
          @ticket = FactoryGirl.create(:ticket, game: @game, user: @user)
          visit game_path(@game)
        end
        it{ should have_selector("a#add_ticket") }
        it{ should have_content("#{@ticket.name}") }
      end
    end

    describe "as moderator" do
      before do
        visit signin_path
        @user = FactoryGirl.create(:user)
        fill_in "Email", with: @user.email
        fill_in "Password", with: @user.password
        click_button "Sign in"

        
      end
      describe "at guides index page" do
        before do
          @guide = FactoryGirl.create(:guide)
          @game = FactoryGirl.create(:game)
          @different_user_guide = FactoryGirl.create(:guide)
          @different_user = FactoryGirl.create(:user)
          @different_user_game = FactoryGirl.create(:game)

          @different_user.guides << @different_user_guide
          @different_user_game.guides << @different_user_guide

          @user.guides << @guide          
          @game.guides << @guide

          visit guides_path
        end
        it{ should have_selector("a#edit_guide_#{@guide.id}") }
        it{ should have_selector("a#delete_guide_#{@guide.id}") }
        it{ should_not have_selector("a#edit_guide_#{@different_user_guide.id}") }
        it{ should_not have_selector("a#delete_guide_#{@different_user_guide.id}") }     
      end
    end
  end

  describe "when user is not signed in" do
    describe "at home page" do
      before{ visit root_path }
      it{ should have_content("Welcome") }
      #show dropdown menu
      it{ should have_selector("span.glyphicon.glyphicon-folder-open") }
      it{ should have_selector("span.glyphicon.glyphicon-tower") }
      it{ should have_selector("span.glyphicon.glyphicon-tag") }
      #home
      it{ should have_selector("span.glyphicon.glyphicon-home") }
      #help
      it{ should have_selector("span.glyphicon.glyphicon-question-sign") }
      #sign in
      it{ should have_selector("span.glyphicon.glyphicon-log-in") }
      #sign up
      it{ should have_selector("span.glyphicon.glyphicon-unchecked") }
      it{ should have_selector("a#sign_up") }
    end
    describe "at user show page" do
      before do
        @user = FactoryGirl.create(:user)
        visit user_path(@user)
      end
      it{ should_not have_content("#{@user.role}") }
      it{ should have_content("#{@user.name}")}
    end
    describe "at game show page" do
      before do
        @game = FactoryGirl.create(:game)
        visit game_path(@game)
      end
      it{ should_not have_selector("a#add_request") }
      it{ should have_content("#{@game.name}") }
    end
    describe "at guides index page" do
      before do
        @guide = FactoryGirl.create(:guide)
        @user = FactoryGirl.create(:user)
        @game = FactoryGirl.create(:game)

        @user.guides << @guide
        @game.guides << @guide

        visit guides_path
      end
      it{ should have_content("#{@guide.name}") }
      it{ should_not have_selector("a#edit_guide_#{@guide.id}") }
      it{ should_not have_selector("a#delete_guide_#{@guide.id}") }
    end    
  end
end