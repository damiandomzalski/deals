# frozen_string_literal: true

class AddIndexOnPipelinedealsId < ActiveRecord::Migration[5.2]
  def change
    add_index :deals, :pipelinedeals_id
  end
end
