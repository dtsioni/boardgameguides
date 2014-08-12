#game pages
require 'spec_helper'

describe "Game pages" do
  
  subject { page }
  #sign in first
  before do

    visit signin_path

    user = FactoryGirl.create(:user)

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"

  end

  describe "new" do

    describe "with valid information" do

      before do

        visit new_game_path

        @game = FactoryGirl.build(:game)

        fill_in "Name", with: @game.name
        fill_in "Description", with: @game.body

        click_button "Submit"

      end
      
      it { should have_selector("div.success") }
      it { should have_title(@game.name) }
      it { should have_content(@game.name) }
 
      describe "after visiting another page" do

        before{ visit root_path }

        it{ should_not have_selector('div.success') }

      end

    end

    describe "with invalid information" do

      before do

        visit new_game_path
        click_button "Submit"

      end

      it{ should have_selector("div.error") }
      
      describe "after visiting another page" do

        before{ visit root_path }

        it{ should_not have_selector('div.error') }

      end

    end

  end

  describe "edit" do

    before do
      visit signin_path
      admin = FactoryGirl.create(:admin)
      fill_in "Email", with: admin.email
      fill_in "Password", with: admin.password
      click_button "Sign in"
      @game = FactoryGirl.create(:game)
    end

    describe "with valid information" do

      before do
        visit edit_game_path(@game)
        fill_in "Name", with: "#{@game.name}x"
        fill_in "Description", with: "#{@game.body}x"
        click_button "Submit"
      end

      it{ should have_selector("div.success")}

    end

    describe "with invalid information" do

      before do
        @clone = FactoryGirl.create(:game)
        visit edit_game_path(@game)
        fill_in "Name", with: "#{@clone.name}"
        fill_in "Description", with: "#{@clone.body}"
        click_button "Submit"
      end

      it{ should have_selector("div.error") }

    end

  end

end


