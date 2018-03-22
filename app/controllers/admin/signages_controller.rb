class Admin::SignagesController < Admin::AppsController
  before_action :find_signage, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @signages = Signage.all
                      .page(params[:page])
                      .send(:order, "#{sorting_name} #{sorting_taxis}")
                      .ransack(id_or_sn_or_title_or_number_or_token_cont_any: keyword)
                      .result(distinct: true)
                      .includes(:shop, :container, :client)

        render json: collection_json(@signages, SignageSerializer)
      end
    end
  end

  def new
    @signage = Signage.new
  end

  def create
    @signage = Signage.new(signage_params)
    if @signage.save
      redirect_to admin_signages_path
    else
      flash['alert'] = @signage.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @signage.update(signage_params)
      redirect_to admin_signages_path
    else
      flash['alert'] = @signage.errors.full_messages
      render :edit
    end
  end

  def destroy
    Signage.where(id: params[:id].split(',')).destroy_all
    @signages = Signage.all
                  .page(params[:page])
                  .order(id: :desc)
                  .includes(:shop, :container, :client)
    render json: collection_json_with_message(@signages, SignageSerializer, 'Delete Success')
  end

  private

  def find_signage
    @signage = Signage.find(params[:id])
  end

  def signage_params
    params.require(:signage).permit(:client_id, :title, :number, :sn, :status, :shop_id, :container_id)
  end

end
