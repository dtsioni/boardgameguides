require 'spec_helper'
require 'cancan/matchers'

describe "User role" do  
  #create ability for cancan and user  
  let(:user){FactoryGirl.create(:user)}
  subject(:ability){ Ability.new(user) }
  #create users and objects to manipulate
  before do
    ability = Ability.new(user)

    @example_user = User.new(name: "Example")
    @example_game = FactoryGirl.create(:game)
    @example_guide = FactoryGirl.create(:guide)
    @example_ticket = FactoryGirl.create(:ticket)

    @different_user_ticket = FactoryGirl.create(:ticket)
    @different_user_guide = FactoryGirl.create(:guide)

    user.tickets << @example_ticket
    user.guides << @example_guide
    @example_game.guides << @example_guide
  end
  #everyone

  #admin
  #SUPERVISE describes both ADMINS and MODERATORS
  describe "when admin" do
    before { user.role = "admin" }
    #users
    describe "is destroying user" do
      it{ should be_able_to(:destroy, @example_user) }
    end
    describe "is updating user" do
      it{ should be_able_to(:update, @example_user) }
    end
    describe "is indexing users" do
      it{ should be_able_to(:index, User) }
    end
    #SUPERVISE describes both ADMINS and MODERATORS
    describe "is supervising users" do
      it{ should be_able_to(:supervise, User) } 
    end   
    #games
    describe "is destroying game" do
      it{ should be_able_to(:destroy, @example_game) }
    end
    describe "is updating game" do
      it{ should be_able_to(:update, @example_game) }
    end
    describe "is indexing game" do
      it{ should be_able_to(:index, Game) }
    end
    describe "is creating game" do
      it{ should be_able_to(:new, Game) }
      it{ should be_able_to(:create, Game)}
    end
    #tickets
    describe "is creating ticket" do
      it{ should be_able_to(:new, Ticket) }
      it{ should be_able_to(:create, Ticket)}
    end
    describe "is showing ticket" do
      it{ should be_able_to(:show, Ticket) }
    end
    describe "is indexing tickets" do
      it{ should be_able_to(:index, Ticket) }
    end
    describe "is editing tickets" do
      it{ should be_able_to(:edit, @example_ticket) }
      it{ should be_able_to(:edit, Ticket) }
      it{ should be_able_to(:edit, @different_user_ticket) }
      it{ should be_able_to(:update, @example_ticket) }
      it{ should be_able_to(:update, Ticket) }
      it{ should be_able_to(:update, @different_user_ticket) }
    end
    describe "is destroying tickets" do
      it{ should be_able_to(:destroy, Ticket) }
    end
    #guides
    describe "is creating guide" do
      it{ should be_able_to(:new, Guide) }
      it{ should be_able_to(:create, Guide) }
    end
    describe "is editing guide" do
      it{ should be_able_to(:edit, Guide) }
      it{ should be_able_to(:update, Guide) }
    end
    describe "is destroying guide" do
      it{ should be_able_to(:destroy, Guide) }
    end
  end
  #moderator
  describe "when moderator" do
    before{ user.role = "moderator" }   
    #users
    describe "is destroying user" do      
      it{ should_not be_able_to(:destroy, @example_user) }
    end
    describe "is updating user" do      
      it{ should be_able_to(:update, @example_user) }
    end
    describe "is indexing users" do
      it{ should_not be_able_to(:index, User)}
    end
    #SUPERVISE describes both ADMINS and MODERATORS
    describe "is supervising users" do
      it{ should be_able_to(:supervise, User) } 
    end     
    #games
    describe "is destroying game" do
      it{ should be_able_to(:destroy, @example_game) }
    end
    describe "is updating game" do 
      it{ should be_able_to(:update, @example_game) }
    end
    describe "is indexing games" do
      it{ should be_able_to(:index, Game) }
    end
    describe "is creating game" do
      it{ should be_able_to(:new, Game) }
      it{ should be_able_to(:create, Game)}
    end 
    #tickets
    describe "is creating ticket" do
      it{ should be_able_to(:new, Ticket)}
      it{ should be_able_to(:create, Ticket)}
    end
    describe "is showing ticket" do
      it{ should be_able_to(:show, Ticket) }
    end
    describe "is indexing tickets" do
      it{ should be_able_to(:index, Ticket) }
    end
    describe "is editing tickets" do
      it{ should be_able_to(:edit, @example_ticket) }
      it{ should be_able_to(:edit, Ticket) }
      it{ should be_able_to(:edit, @different_user_ticket) }
      it{ should be_able_to(:update, @example_ticket) }
      it{ should be_able_to(:update, Ticket) }
      it{ should be_able_to(:update, @different_user_ticket) }
    end
    describe "is destroying tickets" do
      it{ should be_able_to(:destroy, Ticket) }
    end
    #guides
    describe "is creating guide" do
      it{ should be_able_to(:new, Guide) }
      it{ should be_able_to(:create, Guide) }
    end
    describe "is editing guide" do
      it{ should be_able_to(:edit, Guide) }
      it{ should be_able_to(:update, Guide) }
    end
    describe "is destroying guide" do
      it{ should be_able_to(:destroy, Guide) }
    end
  end
  #author
  describe "when author" do
    before { user.role = "author"}
    #users
    describe "is destroying user" do
      it{ should_not be_able_to(:destroy, @example_user) }
    end
    describe "is updating user" do
      it{ should_not be_able_to(:update, @example_user)}
      it{ should be_able_to(:update, user)}
    end
    describe "is indexing users" do
      it{ should_not be_able_to(:index, User)}
    end
    #games
    describe "is destroying game" do
      it{ should_not be_able_to(:destroy, @example_game) }
    end
    describe "is updating game" do
      it{ should_not be_able_to(:update, @example_game) }
    end
    describe "is indexing games" do
      it{ should be_able_to(:index, Game)}
    end
    describe "is creating game" do
      it{ should be_able_to(:new, Game) }
      it{ should be_able_to(:create, Game)}
    end
    #tickets
    describe "is creating tickets" do
      it{ should be_able_to(:new, Ticket) }
      it{ should be_able_to(:create, Ticket)}
    end
    describe "is showing ticket" do
      it{ should be_able_to(:show, Ticket) }
    end
    describe "is indexing tickets" do
      it{ should be_able_to(:index, Ticket) }
    end
    describe "is editing tickets" do
      #can edit ticket it owns, no other tickets
      it{ should be_able_to(:edit, @example_ticket) }
      it{ should_not be_able_to(:edit, @different_user_ticket) }
      it{ should be_able_to(:update, @example_ticket) }
      it{ should_not be_able_to(:update, @different_user_ticket) }
    end
    describe "is destroying ticket" do
      it{ should be_able_to(:destroy, @example_ticket) }
      it{ should_not be_able_to(:destroy, @different_user_ticket) }
    end
    #guides
    describe "is creating guide" do
      it{ should be_able_to(:new, Guide) }
      it{ should be_able_to(:create, Guide) }
    end
    describe "is editing guide" do
      it{ should be_able_to(:edit, @example_guide) }
      it{ should be_able_to(:update, @example_guide) }
      it{ should_not be_able_to(:edit, @different_user_guide) }
      it{ should_not be_able_to(:update, @different_user_guide) }
    end
    describe "is destroying guide" do
      it{ should be_able_to(:destroy, @example_guide) }
      it{ should_not be_able_to(:destroy, @different_user_guide) }
    end

  end

end