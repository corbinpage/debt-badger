require 'rails_helper'

RSpec.describe "Debts", :type => :request do
  describe "GET /debts" do
    it "works! (now write some real specs)" do
      get debts_path
      expect(response.status).to be(200)
    end
  end
end
