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

      # admin has no projects
      page.should have_content 'You have no projects'

      # create 3 projects for member and another 5 in the system
      3.times{@user.projects << FactoryGirl.create(:project)}
      5.times{FactoryGirl.create(:project)}
      @user.save

      visit projects_path

      # make sure that all the projects of member are on the page
      @user.projects.each do |project|
        page.should have_content project.name
      end

      # As admin I should see all actions
      page.should have_content 'Show'
      page.should have_content 'Edit'
      page.should have_content 'Destroy'
    end

    it "should view only my projects with only show option" do
      sign_in_as :member

      # member has no projects
      page.should have_content 'You have no projects'

      # create 3 projects for member and another 5 in the system
      3.times{@user.projects << FactoryGirl.create(:project)}
      5.times{FactoryGirl.create(:project)}
      @user.save

      visit projects_path

      # make sure that all the projects of member are on the page
      @user.projects.each do |project|
        page.should have_content project.name
      end

      # make sure normal member can't see edit or destroy
      page.should have_content 'Show'
      page.should_not have_content 'Edit'
      page.should_not have_content 'Destroy'
    end

  end

  describe "POST /projects/:id/members/add/:user_id" do

    it "should add a member to a certain project" do
      project = FactoryGirl.create(:project)
      member = FactoryGirl.create(:user, :role => :member)
      sign_in_as :admin
      @user.projects << project
      @user.save
      visit projects_path
      click_link 'Show' 
      page.should have_content project.name
      click_link 'Manage Members'
      page.should have_content @user.name

      # add member to the project
      fill_in "user_email", :with => member.email
      click_button "Add to project"
      page.should have_content 'User was added to project'

      #check that member was added
      click_link 'Manage Members'   
      page.should have_content @user.name
      page.should have_content member.name
      project.users.include?(member).should eq true
    end
  end

  describe "POST /projects/:id/members/add/:user_id" do

    it "should remove a member from a certain project" do
      project = FactoryGirl.create(:project)
      member = FactoryGirl.create(:user, :role => :member)

      sign_in_as :admin
      @user.projects << project
      @user.save
      member.projects << project
      member.save

      visit projects_path
      click_link 'Show' 
      page.should have_content project.name
      click_link 'Manage Members'
      page.should have_content @user.name
      page.should have_content member.name

      # remove the member from the project
      remove_member_link = page.all("a", :text => 'Destroy').last
      remove_member_link.click

      #check that member was removed
      click_link 'Manage Members'   
      page.should have_content @user.name
      page.should_not have_content member.name
      project.users.include?(member).should eq false
    end
  end


  
end
