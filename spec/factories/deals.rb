# frozen_string_literal: true

FactoryBot.define do
  factory :deal do
    sequence(:pipelinedeals_id)
    name { Faker::FunnyName.name }
    sequence(:deal_stage_id)
    deal_stage_percentage { rand(0..100) }
    deal_stage_name { Faker::Lorem.word }
    value { Faker::Number.decimal(5,2) }
  end
end
