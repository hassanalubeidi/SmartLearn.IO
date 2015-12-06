require 'rails_helper'

RSpec.describe "interventions/new", :type => :view do
  before(:each) do
    assign(:intervention, Intervention.new(
      :problem => "MyText",
      :fix => "MyText"
    ))
  end

  it "renders new intervention form" do
    render

    assert_select "form[action=?][method=?]", interventions_path, "post" do

      assert_select "textarea#intervention_problem[name=?]", "intervention[problem]"

      assert_select "textarea#intervention_fix[name=?]", "intervention[fix]"
    end
  end
end
