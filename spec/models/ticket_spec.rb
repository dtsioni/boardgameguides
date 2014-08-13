require 'spec_helper'

describe Ticket do
  before{ @ticket = FactoryGirl.create(:ticket) }
  subject{ @ticket }

  it{ should respond_to(:name) }
  it{ should respond_to(:body) }
  it{ should respond_to(:fulfilled) }
  it{ should respond_to(:status) }

  it{ should be_valid }

  describe "when name is too long" do
    before{ @ticket.name = "a" * 122 }
    it{ should_not be_valid }
  end 

  describe "when body is too long" do
    before{ @ticket.body = "a" * 91 }
    it { should_not be_valid }
  end

  describe "when body is too short" do
    before{ @ticket.body = "a" * 17 }
    it{ should_not be_valid }
  end

  describe "when status is too long" do
    before{ @ticket.status = "a" * 51 }
    it{ should_not be_valid }
  end

  describe "when status is too short" do
    before{ @ticket.status = "a" * 2 }
    it{ should_not be_valid }
  end

end
