class Client::ShopsController < Client::AppsController
  before_action :find_shop, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @shops = current_user.client.shops
                   .page(params[:page])
                   .order("shops.#{sorting_name} #{sorting_taxis}")
                   .ransack(id_or_title_or_description_or_country_or_zipcode_or_city_or_district_or_address1_or_telephone_cont_any: keyword)
                   .result(distinct: true)
                   .includes(:signages, :client)

        render json: collection_json(@shops, ShopSerializer)
      end
    end
  end

  def new
    @shop = current_user.client.shops.new
  end

  def create
    @shop = current_user.client.shops.new(shop_params)
    if @shop.save
      redirect_to client_shops_path
    else
      flash['alert'] = @shop.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @shop.update(shop_params)
      redirect_to client_shops_path
    else
      flash['alert'] = @shop.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.client.shops.where(id: params[:id].split(',')).destroy_all
    @shops = current_user.client
               .shops
               .page(params[:page])
               .order(id: :desc)
               .includes(:signages, :client)

    render json: collection_json_with_message(@shops, ShopSerializer,'Delete Success')
  end

  private

  def find_shop
    @shop = current_user.client.shops.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:title, :description, :country, :zipcode, :city, :district, :address1, :telephone)
  end

end
