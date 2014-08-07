require 'spec_helper'
require 'cancan/matchers'

describe "User role" do  
  #create ability for cancan and user  
  let(:user){FactoryGirl.create(:user)}
  subject(:ability){ Ability.new(user) }

  before do
    ability = Ability.new(user)
    @example_user = User.new(name: "Example")
  end
  #everyone

  #moderator
  describe "when moderator" do

    before{ user.role = "moderator" }      
    
    #crud
    describe "is destroying user" do      
      it{ should_not be_able_to(:destroy, @example_user) }
    end
    describe "is updating user" do      
      it{ should be_able_to(:update, @example_user) }
    end
    describe "is indexing users" do
      it{ should_not be_able_to(:index, User)}
    end
    describe "is showing user" do
      it{should be_able_to(:show, @example_user)}
    end     

  end

  describe "when admin" do       

    before { user.role = "admin" }
   
    describe "is destroying user" do
      it{ should be_able_to(:destroy, @example_user) }
    end
    describe "is updating user" do
      it{ should be_able_to(:update, @example_user) }
    end
    describe "is indexing users" do
      it{ should be_able_to(:index, User)}
    end 
    describe "is showing user" do
      it{should be_able_to(:show, @example_user)}
    end

  end

  describe "when author" do

    before { user.role = "author"}

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
    describe "is showing user" do
      it{should be_able_to(:show, @example_user)}
    end  

  end

end