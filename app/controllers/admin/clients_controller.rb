class Admin::ClientsController < Admin::AppsController
  before_action :find_client, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @clients = Client.all
                   .page(params[:page])
                   .order("clients.#{sorting_name} #{sorting_taxis}")
                   .ransack(id_or_title_or_address1_or_telephone_cont_any: keyword)
                   .result(distinct: true)

        render json: collection_json(@clients, ClientSerializer)
      end
    end
  end

  def new
    @client = Client.new
  end


  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to admin_clients_path
    else
      flash['alert'] = @client.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    @client.assign_attributes(client_params)
    if @client.save
      redirect_to admin_clients_path
    else
      flash['alert'] = @client.errors.full_messages
      render :edit
    end
  end

  def destroy
    Client.where(id: params[:id].split(',')).destroy_all
    @clients = Client.all.page(params[:page]).order(id: :desc)
    render json: collection_json_with_message(@clients, ClientSerializer,'Delete Success')
  end

  private

  def find_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:title, :description, :telephone,
                                   :country, :city, :zipcode, :district, :address1,
                                   :ad_impression_price, :ad_click_price, :ad_face_price)

  end

end
