require 'spec_helper'

describe "Releases" do
  describe "POST /releases" do
    it "should create a release for a certain project" do
      sign_in_as :admin
      project = FactoryGirl.create(:project)
      @user.projects << project
      @user.save

      visit project_path project
      click_link 'Releases'
      click_link 'Create Release'
      page.should have_content 'New Release'

      fill_in "release_version", :with => "1.0"

      click_button "Create Release"

      Release.count.should eq 1
      visit project_path project
      click_link 'Releases'
      page.should have_content project.releases.first.version

    end
  end

  describe "GET /releases" do

    it "should view all releases of a certain project" do
      sign_in_as :admin
      project = FactoryGirl.create(:project)
      @user.projects << project
      @user.save

      3.times{ |n| FactoryGirl.create(:release, :project_id => project)}
      project.save

      visit project_path project
      click_link 'Releases'
      
      project.releases.each do |release|
        page.should have_content release.version
      end

    end

  end
end
