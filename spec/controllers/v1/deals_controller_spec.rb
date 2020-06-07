# frozen_string_literal: true

RSpec.describe V1::DealsController do
  describe "GET /v1/deals.json", type: :request do
    let(:json) { JSON.parse(response.body) }
    let!(:deal_1) { create(:deal, deal_stage_percentage: 0, deal_stage_name: "Lost") }
    let!(:deal_2) { create(:deal, deal_stage_percentage: 100, deal_stage_name: "Won") }
    let!(:deal_3) { create(:deal, deal_stage_percentage: 0, deal_stage_name: "Lost") }
    let!(:deal_4) { create(:deal, deal_stage_percentage: 100, deal_stage_name: "Won") }
    let(:sorted_response) {
      {
          deals: [
              {
                  deal_stage_percentage: 0,
                  id: nil,
                  name: "Lost",
                  summed_value: [deal_1.value, deal_3.value].inject(:+)
              },
              {
                  deal_stage_percentage: 100,
                  id: nil,
                  name: "Won",
                  summed_value: [deal_2.value, deal_4.value].inject(:+)
              }
          ]
      }.as_json
    }

    before { get "/v1/deals.json" }

    it "should return deals grouped by deal_stage_name with summed value and ordered by deal_stage_percentage" do
      expect(json).to eq sorted_response
    end
  end
end
