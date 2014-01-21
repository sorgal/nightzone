require 'spec_helper'

describe Code do
  let(:code) {create :code}
  it "codes validation checking" do

    code.should be_valid
  end
end
