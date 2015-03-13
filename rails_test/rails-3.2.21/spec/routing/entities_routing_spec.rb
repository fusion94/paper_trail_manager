require "spec_helper"

describe EntitiesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/entities" }.should route_to(:controller => "entities", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/entities/new" }.should route_to(:controller => "entities", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/entities/1" }.should route_to(:controller => "entities", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/entities/1/edit" }.should route_to(:controller => "entities", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/entities" }.should route_to(:controller => "entities", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/entities/1" }.should route_to(:controller => "entities", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/entities/1" }.should route_to(:controller => "entities", :action => "destroy", :id => "1")
    end

  end
end
