require 'spec_helper'

describe "entities/new.html.erb" do
  before(:each) do
    assign(:entity, stub_model(Entity).as_new_record)
  end

  it "renders new entity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entities_path, :method => "post" do
    end
  end
end
