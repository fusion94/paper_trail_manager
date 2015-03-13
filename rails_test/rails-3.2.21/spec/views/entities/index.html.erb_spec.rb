require 'spec_helper'

describe "entities/index.html.erb" do
  before(:each) do
    assign(:entities, [
      stub_model(Entity),
      stub_model(Entity)
    ])
  end

  it "renders a list of entities" do
    render
  end
end
