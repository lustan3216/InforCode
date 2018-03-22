class Client::CampaignsController < Client::AppsController
  before_action :find_campaign, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do

        campaigns = fetch_campaigns
                      .page(params[:page])
                      .order("campaigns.#{sorting_name} #{sorting_taxis}")
                      .ransack(id_or_name_cont_any: keyword)
                      .result(distinct: true)

        render json: collection_json(campaigns, CampaignSerializer)
      end
    end
  end

  def new
    @campaign = current_user.client.campaigns.new
  end

  def create
    @campaign = current_user.client.campaigns.new(campaign_params)
    if @campaign.save
      redirect_to client_campaigns_path
    else
      flash['alert'] = @campaign.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @campaign.update(campaign_params)
      redirect_to client_campaigns_path
    else
      flash['alert'] = @campaign.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.client.campaigns.where(id: params[:id].split(',')).destroy_all
    campaigns = fetch_campaigns
                  .page(params[:page])
                  .order(id: :desc)

    render json: collection_json_with_message(campaigns, CampaignSerializer, 'Delete Success')
  end

  private

  def find_campaign
    @campaign = current_user.client.campaigns.find(params[:id])
  end

  def fetch_campaigns
    current_user.client.campaigns.includes(:manager, ads: [:manager, :materials, :campaign])
  end

  def campaign_params
    params.require(:campaign).permit(:daily_budget, :name, :manager_id, ad_group_ids: [])
  end

end
