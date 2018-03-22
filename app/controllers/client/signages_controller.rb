class Client::SignagesController < Client::AppsController
  before_action :find_signage, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @signages = current_user.client.signages
                      .page(params[:page])
                      .send(:order, "#{sorting_name} #{sorting_taxis}")
                      .ransack(id_or_sn_or_title_or_number_or_token_cont_any: keyword)
                      .result(distinct: true)
                      .includes(:shop, :container)

        render json: collection_json(@signages, SignageSerializer)
      end
    end
  end

  def new
    @signage = current_user.client.signages.new
  end

  def create
    @signage = current_user.client.signages.new(signage_params)
    if @signage.save
      redirect_to client_signages_path
    else
      flash['alert'] = @signage.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @signage.update(signage_params)
      redirect_to client_signages_path
    else
      flash['alert'] = @signage.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.client.signages.where(id: params[:id].split(',')).destroy_all
    @signages = current_user.client
                  .signages
                  .page(params[:page])
                  .order(id: :desc)
                  .includes(:shop, :container)

    render json: collection_json_with_message(@signages, SignageSerializer, 'Delete Success')
  end

  private

  def find_signage
    @signage = current_user.client.signages.find(params[:id])
  end

  def signage_params
    params.require(:signage).permit(:title, :number, :sn, :status, :shop_id, :container_id)
  end

end
