class Admin::AdsController < Admin::AppsController
  before_action :find_ad, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @ads = fetch_ads
                 .page(params[:page])
                 .order("ads.#{sorting_name} #{sorting_taxis}")
                 .ransack(id_or_name_or_status_cont_any: keyword)
                 .result(distinct: true)

        render json: collection_json(@ads, AdSerializer)
      end
    end
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = Ad.new(ad_params)
    if @ad.save
      redirect_to admin_ads_path
    else
      flash['alert'] = @ad.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @ad.update(ad_params)
      redirect_to admin_ads_path
    else
      flash['alert'] = @ad.errors.full_messages
      render :edit
    end
  end

  def destroy
    Ad.where(id: params[:id].split(',')).destroy_all

    @ads = fetch_ads
             .page(params[:page])
             .order(id: :desc)

    render json: collection_json_with_message(@ads, AdSerializer,'Delete Success')
  end

  private

  def find_ad
    @ad = fetch_ads.find(params[:id])
  end

  def fetch_ads
    Ad.with_deleted.all
      .includes(:client, :manager, :materials, :ad_template)
  end

  def ad_params
    params.require(:ad).permit(:name, :manager_id, :start_at, :end_at, :is_default,
                               :client_id, :ad_template_id, :material_ids,
                               :daily_budget, :discount, :cost)
  end

end
