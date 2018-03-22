class Api::V1::Signages::StatusesController < Api::V1::ApiController
  before_action :find_signage
  before_action :signage_not_found

  def create
    if @signage.update(lat: params[:lat], lng: params[:lng])
      render_200 @signage
    else
      render_403 error_messages: @signage.errors.full_messages
    end
  end

  private

  def find_signage
    @signage = Signage.find_by_sn(params[:id])
  end

  def signage_not_found
    render_404 message: "Signage not found" and return unless @signage
  end
end
