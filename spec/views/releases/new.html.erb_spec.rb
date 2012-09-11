require 'spec_helper'

describe "releases/new" do
  before(:each) do
    assign(:release, stub_model(Release,
      :version => "MyString",
      :project_id => 1
    ).as_new_record)
  end

  it "renders new release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => releases_path, :method => "post" do
      assert_select "input#release_version", :name => "release[version]"
      assert_select "input#release_project_id", :name => "release[project_id]"
    end
  end
end
