class ProjectUserRecordsController < ApplicationController
  # GET /project_user_records
  # GET /project_user_records.json
  def index
    @project_user_records = ProjectUserRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @project_user_records }
    end
  end

  # GET /project_user_records/1
  # GET /project_user_records/1.json
  def show
    @project_user_record = ProjectUserRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project_user_record }
    end
  end

  # GET /project_user_records/new
  # GET /project_user_records/new.json
  def new
    @project_user_record = ProjectUserRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project_user_record }
    end
  end

  # GET /project_user_records/1/edit
  def edit
    @project_user_record = ProjectUserRecord.find(params[:id])
  end

  # POST /project_user_records
  # POST /project_user_records.json
  def create
    @project_user_record = ProjectUserRecord.new(params[:project_user_record])

    respond_to do |format|
      if @project_user_record.save
        format.html { redirect_to @project_user_record, notice: 'Project user record was successfully created.' }
        format.json { render json: @project_user_record, status: :created, location: @project_user_record }
      else
        format.html { render action: "new" }
        format.json { render json: @project_user_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /project_user_records/1
  # PUT /project_user_records/1.json
  def update
    @project_user_record = ProjectUserRecord.find(params[:id])

    respond_to do |format|
      if @project_user_record.update_attributes(params[:project_user_record])
        format.html { redirect_to @project_user_record, notice: 'Project user record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project_user_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_user_records/1
  # DELETE /project_user_records/1.json
  def destroy
    @project_user_record = ProjectUserRecord.find(params[:id])
    @project_user_record.destroy

    respond_to do |format|
      format.html { redirect_to project_user_records_url }
      format.json { head :no_content }
    end
  end
end
