require 'spec_helper'

describe "platforms/show.html.erb" do
  before(:each) do
    @platform = assign(:platform, stub_model(Platform))
  end

  it "renders attributes in <p>" do
    render
  end
end
