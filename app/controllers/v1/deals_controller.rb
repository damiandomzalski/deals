# frozen_string_literal: true

class V1::DealsController < ApplicationController
  def index
    render json: {
        deals: grouped_deals_with_summed_values
    }
  end

    private
      def grouped_deals_with_summed_values
        @grouped_deals_with_summed_values = Deal.select("deal_stage_name as name, SUM(value) as summed_value, deal_stage_percentage").group(:deal_stage_percentage, :deal_stage_name).order(deal_stage_percentage: :asc)
      end
end
