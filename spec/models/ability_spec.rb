require 'spec_helper'
require 'cancan/matchers'

describe "User role" do  
  #create ability for cancan and user  
  let(:user){FactoryGirl.create(:user)}
  subject(:ability){ Ability.new(user) }

  before do
    ability = Ability.new(user)
    @example_user = User.new(name: "Example")
    @example_game = FactoryGirl.create(:game)
  end
  #everyone
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
      it{ should be_able_to(:index, User)}
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

  end

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
      it{ should_not be_able_to(:index, Game)}
    end

  end

end