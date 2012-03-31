require "spec_helper"

describe FormsController do
  describe "routing" do

    it "routes to #index" do
      get("/forms").should route_to("forms#index")
    end

    it "routes to #new" do
      get("/forms/new").should route_to("forms#new")
    end

    it "routes to #show" do
      get("/forms/1").should route_to("forms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/forms/1/edit").should route_to("forms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/forms").should route_to("forms#create")
    end

    it "routes to #update" do
      put("/forms/1").should route_to("forms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/forms/1").should route_to("forms#destroy", :id => "1")
    end

  end
end
