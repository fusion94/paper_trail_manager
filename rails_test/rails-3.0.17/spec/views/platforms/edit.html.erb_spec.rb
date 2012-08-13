require 'spec_helper'

describe "platforms/edit.html.erb" do
  before(:each) do
    @platform = assign(:platform, stub_model(Platform))
  end

  it "renders the edit platform form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => platforms_path(@platform), :method => "post" do
    end
  end
end
