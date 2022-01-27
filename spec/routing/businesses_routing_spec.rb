require "rails_helper"

RSpec.describe BusinessesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/businesses").to route_to("businesses#index")
    end

    it "routes to #show" do
      expect(:get => "/businesses/1").to route_to("businesses#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/businesses").to route_to("businesses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/businesses/1").to route_to("businesses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/businesses/1").to route_to("businesses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/businesses/1").to route_to("businesses#destroy", :id => "1")
    end
  end
end
