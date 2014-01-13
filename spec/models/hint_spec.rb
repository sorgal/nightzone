require 'spec_helper'

describe Hint do
  it "hints validation checking" do
    hint_1 = FactoryGirl.create(:hint)

    hint_1.should be_valid
  end
end
