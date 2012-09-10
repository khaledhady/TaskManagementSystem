require 'spec_helper'

describe "Projects" do

  describe "POST /projects" do #project create

    it "should add project to system" do
      sign_in_as :admin
      visit projects_path
      click_link 'New'
      page.should have_content('New Project')
      current_path.should eq new_project_path
      fill_in "project_name", :with => "ProjectName"
      fill_in "project_identifier", :with => "ProjectIdentifier"
      click_button 'Create Project'
      page.should have_content 'Project was successfully created.'
      Project.count.should eq 1
    end

    it "should raise error as identifier must have no spaces" do
      sign_in_as :admin
      visit projects_path
      click_link 'New'
      page.should have_content('New Project')
      current_path.should eq new_project_path
      fill_in "project_name", :with => "ProjectName"
      fill_in "project_identifier", :with => "Project Identifier"
      click_button 'Create Project'
      page.should have_content 'Identifier must be one word with no spaces'
      Project.count.should eq 0
    end

    it "should raise error as identifier can't be blank" do
      sign_in_as :admin
      visit projects_path
      click_link 'New'
      page.should have_content('New Project')
      current_path.should eq new_project_path
      fill_in "project_name", :with => "ProjectName"
      click_button 'Create Project'
      page.should have_content "Identifier can't be blank"
      Project.count.should eq 0
    end

    it "should raise error as name can't be blank" do
      sign_in_as :admin
      visit projects_path
      click_link 'New'
      page.should have_content('New Project')
      current_path.should eq new_project_path
      fill_in "project_identifier", :with => "Project Identifier"
      click_button 'Create Project'
      page.should have_content "Name can't be blank"
      Project.count.should eq 0
    end

    it "creates sub project for existing project" do
    
      @project = FactoryGirl.create(:project)
      sign_in_as :admin
      @project.users << @user
      @project.save
      @project.is_root?.should eq true
      visit projects_path
      click_link 'Show'
      page.should have_content @project.name
      click_link 'Sub Projects'
      page.should have_content('Has no sub projects')
      click_link 'Create Sub Project'
      page.should have_content('New Project')
      current_path.should eq new_project_path
      fill_in "project_name", :with => "SubProjectName"
      fill_in "project_identifier", :with => "SubProjectIdentifier"
      click_button 'Create Project'
      page.should have_content 'Project was successfully created.'
      Project.count.should eq 2
      @project.children.count.should eq 1
      @project.children.first.name.should eq 'SubProjectName'
      visit project_path(@project)
      click_link 'Sub Projects'
      page.should_not have_content('Has no sub projects')
      page.should have_content('SubProjectName')

    end

  end

  describe "GET /projects" do #projects view

    it "should view only my projects with show, edit and destroy options" do
      sign_in_as :admin
      page.should have_content 'You have no projects'
      3.times{@user.projects << FactoryGirl.create(:project)}
      5.times{FactoryGirl.create(:project)}
      @user.save
      visit projects_path
      @user.projects.each do |project|
        page.should have_content project.name
      end
      page.should have_content 'Show'
      page.should have_content 'Edit'
      page.should have_content 'Destroy'
    end

    it "should view only my projects with only show option" do
      sign_in_as :member
      page.should have_content 'You have no projects'
      3.times{@user.projects << FactoryGirl.create(:project)}
      5.times{FactoryGirl.create(:project)}
      @user.save
      visit projects_path
      @user.projects.each do |project|
        page.should have_content project.name
      end
      page.should have_content 'Show'
      page.should_not have_content 'Edit'
      page.should_not have_content 'Destroy'
    end

  end


  
end
