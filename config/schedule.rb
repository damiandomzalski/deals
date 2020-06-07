# frozen_string_literal: true

every 3.hours do
  runner "ImportDealsService.new.call"
end
