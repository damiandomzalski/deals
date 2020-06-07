# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1, default: { format: "json" } do
    get "deals", to: "deals#index"
  end

  # Forward non-api && non-ajax requests to StaticController
  get "*page", to: "static#index", constraints: -> (req) do
    !req.xhr? && req.format.html?
  end

  root "static#index"
end
