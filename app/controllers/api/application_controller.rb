class Api::ApplicationController < ActionController::API
  respond_to :json

  include ActionController::Serialization
  include ActionController::MimeResponds
  include ::Render
end
