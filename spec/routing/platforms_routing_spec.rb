require "spec_helper"

describe PlatformsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/platforms" }.should route_to(:controller => "platforms", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/platforms/new" }.should route_to(:controller => "platforms", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/platforms/1" }.should route_to(:controller => "platforms", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/platforms/1/edit" }.should route_to(:controller => "platforms", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/platforms" }.should route_to(:controller => "platforms", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/platforms/1" }.should route_to(:controller => "platforms", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/platforms/1" }.should route_to(:controller => "platforms", :action => "destroy", :id => "1")
    end

  end
end
