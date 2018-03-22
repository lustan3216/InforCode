class Admin::AdGroupsController < Admin::AppsController
  before_action :find_ad_group, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @ad_groups = fetch_ad_groups
                       .page(params[:page])
                       .order("ad_groups.#{sorting_name} #{sorting_taxis}")
                       .ransack(id_or_name_cont_any: keyword)
                       .result(distinct: true)

        render json: collection_json(@ad_groups, AdGroupSerializer)
      end
    end
  end

  def new
    @ad_group = AdGroup.new
  end

  def create
    @ad_group = AdGroup.new(ad_group_params)
    if @ad_group.save
      redirect_to admin_ad_groups_path
    else
      flash['alert'] = @ad_group.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @ad_group.update(ad_group_params)
      redirect_to admin_ad_groups_path
    else
      flash['alert'] = @ad_group.errors.full_messages
      render :edit
    end
  end

  def destroy
    AdGroup.where(id: params[:id].split(',')).destroy_all
    @ad_groups = fetch_ad_groups
                   .page(params[:page])
                   .order(id: :desc)

    render json: collection_json_with_message(@ad_groups, AdGroupSerializer,'Delete Success')
  end

  private

  def find_ad_group
    @ad_group = fetch_ad_groups.find(params[:id])
  end

  def fetch_ad_groups
    AdGroup.with_deleted.all
      .includes(:client, :manager, :campaign, ads: [:manager, :materials, :campaign])
  end

  def ad_group_params
    params.require(:ad_group).permit(:client_id, :manager_id, :name, ad_ids: [])
  end

end
