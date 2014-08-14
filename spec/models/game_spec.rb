require 'spec_helper'

describe Game do

  before{ @game = FactoryGirl.create(:game)}

  subject{ @game }

  it{ should respond_to(:name)}
  it{ should respond_to(:body)}
  it{ should respond_to(:user_id)}

  it{ should be_valid }
  #prescence of all fields
  describe "when name is not present" do
    before{ @game.name = " " }
    it{ should_not be_valid }
  end
  
  describe "when body is not present" do
    before{ @game.body = " "}
    it{ should_not be_valid }
  end

  describe "when user_id is not present" do
    before{ @game.user_id = " " }
    it{ should_not be_valid }
  end
  #length of fields
  describe "when name is too long" do
    before{ @game.name = "a" * 51 }
    it{ should_not be_valid }
  end
  #uniqueness of fields
  describe "when name is already taken" do
    it "should not be valid" do
      game_with_same_name = @game.dup
      game_with_same_name.name = @game.name.upcase      
      game_with_same_name.should_not be_valid
    end
  end

  describe "when body is too long" do

    before{ @game.body = "a" * 127 }
    it{ should_not be_valid }

  end


end