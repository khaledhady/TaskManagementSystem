require 'spec_helper'

describe "releases/edit" do
  before(:each) do
    @release = assign(:release, stub_model(Release,
      :version => "MyString",
      :project_id => 1
    ))
  end

  it "renders the edit release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => releases_path(@release), :method => "post" do
      assert_select "input#release_version", :name => "release[version]"
      assert_select "input#release_project_id", :name => "release[project_id]"
    end
  end
end
