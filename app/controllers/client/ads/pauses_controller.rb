class Client::Ads::PausesController < Client::AdsController
  before_action :find_ads

  def create
    message = if @ads.many?
                @ads.pause_all
                'Action performing, please wait'
              else
                ad = @ads.first
                ad.pause
                ad.errors.full_messages
              end

    refresh_ads = fetch_ads
                    .page(params[:page])
                    .order(id: :desc)

    render json: collection_json_with_message(refresh_ads,
                                              AdSerializer,
                                              message)
  end

  private

  def find_ads
    @ads = fetch_ads.where(id: params[:ad_id].split(','))
  end

end
