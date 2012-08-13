require 'spec_helper'

describe Platform do
  context "when creating a sample record" do
    subject { FactoryGirl.create(:platform) }

    its(:id)     { should be_present }
    its(:name)   { should be_present }
    its(:status) { should be_present }

    it { should be_valid }
    it { should_not be_a_new_record }
  end
end
