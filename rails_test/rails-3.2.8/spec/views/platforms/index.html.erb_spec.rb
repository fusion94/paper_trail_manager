require 'spec_helper'

describe "platforms/index.html.erb" do
  before(:each) do
    assign(:platforms, [
      stub_model(Platform),
      stub_model(Platform)
    ])
  end

  it "renders a list of platforms" do
    render
  end
end
