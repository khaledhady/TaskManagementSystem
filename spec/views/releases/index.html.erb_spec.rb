require 'spec_helper'

describe "releases/index" do
  before(:each) do
    assign(:releases, [
      stub_model(Release,
        :version => "Version",
        :project_id => 1
      ),
      stub_model(Release,
        :version => "Version",
        :project_id => 1
      )
    ])
  end

  it "renders a list of releases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Version".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
