require 'spec_helper'

describe "project_user_records/edit" do
  before(:each) do
    @project_user_record = assign(:project_user_record, stub_model(ProjectUserRecord))
  end

  it "renders the edit project_user_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => project_user_records_path(@project_user_record), :method => "post" do
    end
  end
end
