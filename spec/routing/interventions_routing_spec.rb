require "rails_helper"

RSpec.describe InterventionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/interventions").to route_to("interventions#index")
    end

    it "routes to #new" do
      expect(:get => "/interventions/new").to route_to("interventions#new")
    end

    it "routes to #show" do
      expect(:get => "/interventions/1").to route_to("interventions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/interventions/1/edit").to route_to("interventions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/interventions").to route_to("interventions#create")
    end

    it "routes to #update" do
      expect(:put => "/interventions/1").to route_to("interventions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/interventions/1").to route_to("interventions#destroy", :id => "1")
    end

  end
end
