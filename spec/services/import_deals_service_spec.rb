# frozen_string_literal: true

RSpec.describe ImportDealsService do
  describe "#call" do
    let(:subject) { ImportDealsService.new.call }

    context "when PipelineDeals return an empty array" do
      let(:response) { [] }
      let(:pipelinedeals_response) { double }

      before do
        allow_any_instance_of(described_class).to receive(:pipelinedeals_response).and_return(response)
      end

      it "should not change count of deals in DB" do
        expect { subject }.not_to change(Deal, :count)
      end
    end

    context "when PipelineDeals return list of deals defined in /fixtures" do
      it "should change count of deals in DB by 2" do
        expect { subject }.to change(Deal, :count).by(2)
      end
    end
  end
end
