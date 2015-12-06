require 'rails_helper'

RSpec.describe "interventions/index", :type => :view do
  before(:each) do
    assign(:interventions, [
      Intervention.create!(
        :problem => "MyText",
        :fix => "MyText"
      ),
      Intervention.create!(
        :problem => "MyText",
        :fix => "MyText"
      )
    ])
  end

  it "renders a list of interventions" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
