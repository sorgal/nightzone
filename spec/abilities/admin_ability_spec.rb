require 'spec_helper'

describe "User" do
  describe "abilities" do
    subject(:ability){ AdminAbility.new(admin_user) }
    let(:admin_user){ nil }

    context "when is an account manager" do
      let(:admin_user){ create :admin_user, email: "admin#{rand(1000)}@example.com" }

      it{ should be_able_to(:manage, :all) }
    end
  end
end
