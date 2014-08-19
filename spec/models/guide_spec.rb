require 'spec_helper'

describe Guide do
  before{ @guide = FactoryGirl.create(:guide) }

  subject{ @guide }

  it{ should respond_to(:name) }
  it{ should respond_to(:body) }
  it{ should respond_to(:format) }
  it{ should respond_to(:link) }
  it{ should respond_to(:game_id) }
  it{ should respond_to(:user_id) }

  it{ should be_valid }

  describe "when name is not present" do
    before{ @guide.name = " " }
    it{ should_not be_valid }
  end

  describe "when body is not present" do
    before{ @guide.body = " " }
    it{ should be_valid }
  end

  describe "when format is not present" do
    before{ @guide.format = " " }
    it{ should_not be_valid }
  end

  describe "when link is not present" do
    before{ @guide.link = " " }
    it{ should be_valid }
  end

  describe "when user_id is not present" do
    before{ @guide.user_id = " " }
    it{ should_not be_valid }
  end

  describe "when game_id is not present" do
    before{ @guide.game_id = " " }
    it{ should_not be_valid }
  end

  describe "when name is too short" do
    before{ @guide.name = "a" * 4 }
    it{ should_not be_valid }
  end

  describe "when name is too long" do
    before{ @guide.name = "a" * 101 }
    it{ should_not be_valid }
  end

end
