class Client::ManagersController < Client::AppsController
  before_action :find_manager, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @managers = current_user.client.managers
                   .page(params[:page])
                   .order("managers.#{sorting_name} #{sorting_taxis}")
                   .ransack(id_or_email_any: keyword)
                   .result(distinct: true)

        render json: collection_json(@managers, ManagerSerializer)
      end
    end
  end

  def new
    @manager = current_user.client.managers.new
  end

  def create
    @manager = current_user.client.managers.new(manager_params)
    if @manager.save
      redirect_to client_managers_path
    else
      flash['alert'] = @manager.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    @manager.assign_attributes(manager_params)
    if @manager.save
      redirect_to client_managers_path
    else
      flash['alert'] = @manager.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.client.managers.where(id: params[:id].split(',')).destroy_all
    @managers = current_user.client.managers.page(params[:page]).order(id: :desc)
    render json: collection_json_with_message(@managers, ManagerSerializer,'Delete Success')
  end

  private

  def find_manager
    @manager = current_user.client.managers.find(params[:id])
  end

  def manager_params
    _params = params.require(:manager).permit(:name, :email, :password, :password_confirmation, :daily_budget)

    if _params.as_json['password'].blank?
      _params.reject!{|x| x.include?('password')}
    else
      _params
    end
  end

end
