class Client::SignageAdUnitsController < Client::AppsController
  before_action :find_signage_ad_unit, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @signage_ad_units = current_user.client.signage_ad_units
                              .page(params[:page])
                              .order("signage_ad_units.#{sorting_name} #{sorting_taxis}")
                              .ransack(id_or_name_or_status_cont_any: keyword)
                              .result(distinct: true)
                              .includes(:ad_template ,ads: [:manager, :materials, :campaign])

        render json: collection_json(@signage_ad_units, SignageAdUnitSerializer, scope: current_user)
      end
    end
  end

  def new
    @signage_ad_unit = current_user.client.signage_ad_units.new
  end

  def create
    @signage_ad_unit = current_user.client.signage_ad_units.new(signage_ad_unit_params)
    if @signage_ad_unit.save
      redirect_to client_signage_ad_units_path
    else
      flash['alert'] = @signage_ad_unit.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @signage_ad_unit.update(signage_ad_unit_params)
      redirect_to client_signage_ad_units_path
    else
      flash['alert'] = @signage_ad_unit.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.client.signage_ad_units.where(id: params[:id].split(',')).delete_all
    @signage_ad_units = current_user.client
                          .signage_ad_units
                          .page(params[:page])
                          .order(id: :desc)
                          .includes(:ad_template ,ads: [:manager, :materials, :campaign])
    render json: collection_json_with_message(@signage_ad_units, SignageAdUnitSerializer,'Delete Success')
  end

  private

  def find_signage_ad_unit
    @signage_ad_unit = current_user.client.signage_ad_units.find(params[:id])
  end

  def signage_ad_unit_params
    params.require(:signage_ad_unit).permit(:name, :signage_id, :campaign_id, :ad_template_id, :title, :mode,
                                            signage_ad_unit_contents_attributes: [:id, :ad_id, :position, :_destroy])
  end

end
