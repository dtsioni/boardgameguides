require 'spec_helper'

describe Document do
  before{ @document = FactoryGirl.create(:document) }
  subject{ @document }

  it{ should respond_to(:name) }
  it{ should respond_to(:link) }
  it{ should respond_to(:format) }
  it{ should respond_to(:user_id) }
  it{ should respond_to(:game_id) }

  it{ should be_valid }

  describe "when name is not present" do
    before{ @document.name = " " }
    it{ should_not be_valid }
  end
  describe "when link is not present" do
    before{ @document.link = " " }
    it{ should_not be_valid }
  end
  describe "when format is not present" do
    before{ @document.format = " " }
    it{ should_not be_valid }
  end
  describe "when user_id is not present" do
    before{ @document.user_id = " "}
    it{ should_not be_valid }
  end
  describe "when game_id is not present" do
    before{ @document.game_id = " " }
    it{ should_not be_valid }
  end
  describe "when name is too short" do
    before{ @document.name = "a" * 4 }
    it{ should_not be_valid }
  end
  describe "when name is too long" do
    before{ @document.name = "a" * 51 }
    it{ should_not be_valid }
  end
  describe "when name is already taken" do
    it "should not be valid" do
      doc_with_same_name = @document.dup
      doc_with_same_name.name = @document.name.upcase
      doc_with_same_name.should_not be_valid
    end
  end
  describe "when link is already taken" do
    it "should not be valid" do
      doc_with_same_link = @document.dup
      doc_with_same_link.link = @document.link
      doc_with_same_link.should_not be_valid
    end
  end
end
