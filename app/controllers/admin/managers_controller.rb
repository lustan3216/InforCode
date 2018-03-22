class Admin::ManagersController < Admin::AppsController
  before_action :find_manager, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @managers = Manager.all
                      .page(params[:page])
                      .order("managers.#{sorting_name} #{sorting_taxis}")
                      .ransack(id_or_email_any: keyword)
                      .result(distinct: true)
                      .includes(:client, :ads)

        render json: collection_json(@managers, ManagerSerializer)
      end
    end
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new(manager_params)
    @manager.remaining_sum += params[:add_money].to_i
    if @manager.save
      redirect_to admin_managers_path
    else
      flash['alert'] = @manager.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    @manager.assign_attributes(manager_params)
    @manager.remaining_sum += params[:add_money].to_i
    if @manager.save
      redirect_to admin_managers_path
    else
      flash['alert'] = @manager.errors.full_messages
      render :edit
    end
  end

  def destroy
    Manager.where(id: params[:id].split(',')).destroy_all
    @managers = Manager.all
                  .page(params[:page])
                  .order(id: :desc)
                  .includes(:client, :ads)
    render json: collection_json_with_message(@managers, ManagerSerializer,'Delete Success')
  end

  private

  def find_manager
    @manager = Manager.find(params[:id])
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
