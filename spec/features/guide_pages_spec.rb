require 'spec_helper'

describe "Guide pages" do

  subject{ page }
  describe "when signed in" do

    before do
      #sign in as user
      visit signin_path
      @user = FactoryGirl.create(:user)
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Sign in"

      @game = FactoryGirl.create(:game)
      @guide = FactoryGirl.create(:guide)

      @game.guides << @guide
      @user.guides << @guide    
    end

    describe "when on new page" do
      before{ visit new_game_guide_path(@game.id) }
      it{ should have_content("New Guide") }
      it{ should have_content("#{@game.name}") }
      describe "fill in valid information" do
        before do
          fill_in "Name", with: @guide.name
          fill_in "Body", with: @guide.body
          fill_in "Format", with: @guide.format
          fill_in "Link", with: @guide.link
          click_button "Submit"
        end
        it{ should have_selector("div.success") }
        describe "after visiting another page" do
          before{ visit root_path }
          it{ should_not have_selector("div.success") }
        end
      end
      describe "fill in invalid information" do
        before{ click_button "Submit" }
        it{ should have_selector("div.error") }
        describe "after visiting another page" do
          before{ visit root_path }
          it{ should_not have_selector("div.error") }
        end
      end
    end

    describe "when on show page" do
      before {visit guide_path(@guide) }
      it{ should have_content("#{@guide.name}") }
      it{ should have_content("#{@guide.format}") }
      it{ should have_content("#{@guide.link}") }
    end

    describe "when editing" do
      before{ visit edit_guide_path(@guide) }
      it{ should have_content("#{@guide.name}") }
      it{ should have_content("Edit") }

      describe "with valid information" do
        before do
          fill_in "Name", with: "#{@guide.name}x"
          fill_in "Format", with: "#{@guide.format}x"
          fill_in "Link", with: "#{@guide.link}x"
          fill_in "Body", with: "#{@guide.body}x"
          click_button "Submit"
        end
        it{ should have_selector("div.success") }
        describe "then visiting another page" do
          before{ visit root_path }
          it{ should_not have_selector("div.success") }
        end
      end

      describe "with invalid information" do
        before do
          fill_in "Name", with: ""
          click_button "Submit"
        end
        it{ should have_selector("div.error") }
        describe "then visiting another page" do
          before{ visit root_path }
          it{ should_not have_selector("div.error") }
        end
      end
    end

    describe "when indexing" do
      before{ visit guides_path }
      it{ should have_content("Guides") }
      it{ should have_selector("a#edit_guide_#{@guide.id}") }
      it{ should have_selector("a#delete_guide_#{@guide.id}") }
    end
  end
    

  

end