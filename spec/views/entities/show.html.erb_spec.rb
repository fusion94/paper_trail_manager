require 'spec_helper'

describe "entities/show.html.erb" do
  before(:each) do
    @entity = assign(:entity, stub_model(Entity))
  end

  it "renders attributes in <p>" do
    render
  end
end
