require 'rails_helper'

RSpec.describe "interventions/show", :type => :view do
  before(:each) do
    @intervention = assign(:intervention, Intervention.create!(
      :problem => "MyText",
      :fix => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
