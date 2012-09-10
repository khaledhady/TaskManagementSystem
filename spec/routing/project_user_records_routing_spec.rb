require "spec_helper"

describe ProjectUserRecordsController do
  describe "routing" do

    it "routes to #index" do
      get("/project_user_records").should route_to("project_user_records#index")
    end

    it "routes to #new" do
      get("/project_user_records/new").should route_to("project_user_records#new")
    end

    it "routes to #show" do
      get("/project_user_records/1").should route_to("project_user_records#show", :id => "1")
    end

    it "routes to #edit" do
      get("/project_user_records/1/edit").should route_to("project_user_records#edit", :id => "1")
    end

    it "routes to #create" do
      post("/project_user_records").should route_to("project_user_records#create")
    end

    it "routes to #update" do
      put("/project_user_records/1").should route_to("project_user_records#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/project_user_records/1").should route_to("project_user_records#destroy", :id => "1")
    end

  end
end
