class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /projects
  # GET /projects.json
  def index
    # show only projects I am member of and get only root projects (have no parents)
    @projects = current_user.projects.where(:ancestry => nil)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    id = params[:identifier]
    begin
        @project = Project.find(id)
      rescue
        @project = Project.find_by_identifier(id)  
    end
    @users = @project.users
    @releases = @project.releases

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new
    @project.parent_id = params[:parent_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    
    start_date = Date.new(params[:project]["start_date(1i)"].to_i,
                    params[:project]["start_date(2i)"].to_i,
                    params[:project]["start_date(3i)"].to_i)
    end_date = Date.new(params[:project]["end_date(1i)"].to_i,
                    params[:project]["end_date(2i)"].to_i,
                    params[:project]["end_date(3i)"].to_i)
    @project = Project.new(:name => params[:project][:name],
                           :identifier => params[:project][:identifier],
                           :start_date => start_date,
                           :end_date => end_date)

    # if we are creating a sub project
    if params[:project][:parent_id]
      @project.parent = Project.find(params[:project][:parent_id])
    end

    @project.users << current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      start_date = Date.new(params[:project]["start_date(1i)"].to_i,
                    params[:project]["start_date(2i)"].to_i,
                    params[:project]["start_date(3i)"].to_i)
      end_date = Date.new(params[:project]["end_date(1i)"].to_i,
                      params[:project]["end_date(2i)"].to_i,
                      params[:project]["end_date(3i)"].to_i)
      @project.name = params[:project][:name]
      @project.identifier = params[:project][:identifier]
      @project.start_date = start_date
      @project.end_date = end_date

      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end


  def add_member
    new_member = User.find_by_email(params[:user_email])
    @project = Project.find(params[:id])
    @project.users << new_member
    if @project.save
      redirect_to project_path(@project), :notice => "User was added to project"
    else
      redirect_to project_path(@project), :alert => "User couldn't be added to project"
    end

  end

  def remove_member
    removed_member = User.find(params[:user_id])
    @project = Project.find(params[:id])
    @project.users.delete removed_member
    if @project.save
      redirect_to project_path(@project), :notice => "User was removed from project"
    else
      redirect_to project_path(@project), :alert => "User couldn't be removed from project"
    end
  end
end
