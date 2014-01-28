require 'spec_helper'

describe "User" do
  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is an account manager" do
      let(:user){ create :user }

      it{ should be_able_to(:read, :all) }
    end
  end
end

