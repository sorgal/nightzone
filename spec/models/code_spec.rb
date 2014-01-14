require 'spec_helper'

describe Code do
  it "codes validation checking" do
    code_1 = FactoryGirl.create(:code)

    code_1.should be_valid
  end
end
