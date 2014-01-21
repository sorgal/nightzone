require 'spec_helper'

describe Hint do

  let(:hint) {create :hint}

  it "hints validation checking" do

    hint.should be_valid
  end
end
