require 'spec_helper'

describe "Ticket pages" do

  subject{ page }

  before do
    @game = FactoryGirl.create(:game)
    @ticket = FactoryGirl.create(:ticket)
    @game.tickets << (@ticket)
    #sign in as admin
    visit signin_path
    @admin = FactoryGirl.create(:admin)
    fill_in "Email", with: @admin.email
    fill_in "Password", with: @admin.password
    click_button "Sign in"
  end
 
  describe "show" do
    before{ visit ticket_path(@ticket) }
    it{ should have_content(@ticket.name) }
  end

  describe "new" do
    before{ visit new_game_ticket_path(@game) }
    it{ should have_content("New Ticket") }
    describe "with valid information" do
      before do
        fill_in "Name", with: @ticket.name
        fill_in "Description", with: @ticket.body
        click_button "Submit"
      end
      it{ should have_selector("div.success") }      
      describe "then visit another page" do
        before{ visit root_path }
        it{ should_not have_selector("div.success")}
      end
    end
    describe "with invalid information" do
      before{ click_button "Submit" }
      it{ should have_selector("div.error") }
      describe "then visit another page" do
        before{ visit root_path }
        it{ should_not have_selector("div.error") }
      end
    end
  end

  describe "edit" do
    before{ visit edit_ticket_path(@ticket) }
    it{ should have_content("Edit Ticket") }
    it{ should have_content("#{@ticket.name}")}
    describe "with valid information" do
      before do
        fill_in "Name", with: "#{@ticket.name}x"
        fill_in "Description", with: "#{@ticket.body}x"
        click_button "Submit"
      end
      it{ should have_selector("div.success") }
    end
    describe "with invalid information" do
      before do
        fill_in "Name", with: ""
        fill_in "Description", with: ""
        click_button "Submit"
      end
      it{ should have_selector("div.error") }
      describe "after visiting another page" do
        before{ visit root_path }
        it{ should_not have_selector("div.error") }
      end
    end
  end

  describe "index as non admin" do
    before do
      visit signin_path
      @user = FactoryGirl.create(:user)
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Sign in"

      @ticket = FactoryGirl.create(:ticket)
      @not_my_ticket = FactoryGirl.create(:ticket)
      @ticket.user_id = @user.id
      @user.tickets << @ticket      
      #sign in as non admin      
      visit tickets_path
    end
    it{ should have_selector("a#edit_ticket_#{@ticket.id}") }
    it{ should_not have_selector("a#edit_ticket_#{@not_my_ticket.id}") }
    it{ should have_selector("a#delete_ticket_#{@ticket.id}") }
    it{ should_not have_selector("a#delete_ticket_#{@not_my_ticket.id}") }
  end


end