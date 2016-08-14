require 'rails_helper'

describe User do
  describe '#create' do
    describe "with valid attributes" do
      it "is valid with all information"
    end
    describe "without valid attributes" do
      it "is invalid without a name"
      it "is invalid without a email"
      it "is invalid without a password"
      it "is invalid without a password_confirmation although with a password"
      it "is invalid with a duplicate email address"
      it "is invalid with a password that have less than 7 characters"
    end
  end
end
