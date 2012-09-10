require 'spec_helper'

describe "project_user_records/new" do
  before(:each) do
    assign(:project_user_record, stub_model(ProjectUserRecord).as_new_record)
  end

  it "renders new project_user_record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => project_user_records_path, :method => "post" do
    end
  end
end
