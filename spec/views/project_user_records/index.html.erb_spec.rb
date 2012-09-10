require 'spec_helper'

describe "project_user_records/index" do
  before(:each) do
    assign(:project_user_records, [
      stub_model(ProjectUserRecord),
      stub_model(ProjectUserRecord)
    ])
  end

  it "renders a list of project_user_records" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
