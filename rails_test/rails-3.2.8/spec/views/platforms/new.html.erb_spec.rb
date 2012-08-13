require 'spec_helper'

describe "platforms/new.html.erb" do
  before(:each) do
    assign(:platform, stub_model(Platform).as_new_record)
  end

  it "renders new platform form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => platforms_path, :method => "post" do
    end
  end
end
