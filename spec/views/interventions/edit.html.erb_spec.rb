require 'rails_helper'

RSpec.describe "interventions/edit", :type => :view do
  before(:each) do
    @intervention = assign(:intervention, Intervention.create!(
      :problem => "MyText",
      :fix => "MyText"
    ))
  end

  it "renders the edit intervention form" do
    render

    assert_select "form[action=?][method=?]", intervention_path(@intervention), "post" do

      assert_select "textarea#intervention_problem[name=?]", "intervention[problem]"

      assert_select "textarea#intervention_fix[name=?]", "intervention[fix]"
    end
  end
end
