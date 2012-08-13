require 'spec_helper'

describe "entities/edit.html.erb" do
  before(:each) do
    @entity = assign(:entity, stub_model(Entity))
  end

  it "renders the edit entity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entities_path(@entity), :method => "post" do
    end
  end
end
