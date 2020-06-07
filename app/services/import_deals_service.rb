# frozen_string_literal: true

class ImportDealsService
  attr_accessor :deals_to_process

  def initialize
    @deals_to_process = []
  end

  def call
    fetch_deals
    save_deals_in_db
  end

    private
      def fetch_deals
        deals_to_process.concat pipelinedeals_response["entries"]
        call_next_pages if more_than_one_page_returned?
      end

      def save_deals_in_db
        deals_to_process.each do |deal|
          next if Deal.find_by(pipelinedeals_id: deal["id"]).present?
          Deal.create!(
            pipelinedeals_id: deal["id"],
              name: deal["name"],
              value: deal["value"],
              deal_stage_id: deal["deal_stage"]["id"],
              deal_stage_percentage: deal["deal_stage"]["percent"],
              deal_stage_name: deal["deal_stage"]["name"],
          )
        end
      end

      def more_than_one_page_returned?
        pages_count > 1
      end

      def call_next_pages
        (2..pages_count).each do |page|
          request_params[:page] = page
          deals_to_process.concat pipelinedeals_response["entries"]
        end
      end

      def pages_count
        @pages_count = pipelinedeals_response["pagination"]["pages"]
      end

      def request_params
        @request_params = {
            api_key: ENV["PIPELINEDEALS_API_KEY"]
        }
      end

      def pipelinedeals_response
        @pipelinedeals_deals = JSON.parse RestClient.get Settings.pipelinedeals.deals_api_url, params: request_params
      end
end
