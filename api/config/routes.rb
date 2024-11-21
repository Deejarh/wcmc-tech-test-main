# frozen_string_literal: true

# @see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  namespace :v1 do
    get 'species/by_location', to: 'species#by_location'
    get 'species/by_scientific_name_id', to: 'species#by_scientific_name_id'
  end
end
