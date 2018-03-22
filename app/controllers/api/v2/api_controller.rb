class Api::V2::ApiController < Api::ApplicationController

  # before_action :authorize_api_clients

  private

  # def authorize_api_clients
  #   authenticate_or_request_with_http_basic do |username, password|
  #     ApiClient.where(:api_key => username, :password => password).first
  #   end
  # end
end