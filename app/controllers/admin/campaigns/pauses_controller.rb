class Admin::Campaigns::PausesController < Admin::CampaignsController
  before_action :find_campaigns

  def create
    @campaigns.pause_all

    refresh_campaigns = fetch_campaigns
                          .page(params[:page])
                          .order(id: :desc)

    render json: collection_json_with_message(refresh_campaigns,
                                              CampaignSerializer,
                                              'Action performing, please wait')
  end

  private

  def find_campaigns
    @campaigns = Campaign.where(id: params[:campaign_id].split(','))
  end

end
