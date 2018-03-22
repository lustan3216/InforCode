class Api::V1::Signages::ProbesController < Api::V1::ApiController
  before_action :find_signage
  before_action :signage_not_found

  def show
    render_200 @signage,
               { content_url: @signage.content_url },
               { serializer: SignageInfosSerializer }
  end

  private

  def find_signage
    @signage = Signage.find_by_sn(params[:id])
  end

  def signage_not_found
    render_404 message: "Signage not found" and return unless @signage
  end
end
