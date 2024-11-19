# frozen_string_literal: true

module V1
  class ApplicationController < ActionController::API
    # @see https://stackoverflow.com/a/35985101/1090438
    include ActionController::MimeResponds

    respond_to :json
  end
end
