require 'spec_helper'

describe "project_user_records/show" do
  before(:each) do
    @project_user_record = assign(:project_user_record, stub_model(ProjectUserRecord))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
