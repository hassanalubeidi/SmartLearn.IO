require 'rails_helper'

RSpec.describe "Interventions", :type => :request do
  describe "GET /interventions" do
    it "works! (now write some real specs)" do
      get interventions_path
      expect(response.status).to be(200)
    end
  end
end
