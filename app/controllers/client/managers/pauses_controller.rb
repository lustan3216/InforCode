class Client::Managers::PausesController < Client::AppsController
  before_action :find_managers

  def create
    @managers.pause_all

    refresh_managers = current_user.client.managers.page(params[:page]).order(id: :desc)

    render json: collection_json_with_message(refresh_managers,
                                              ManagerSerializer,
                                              'Action performing, please wait')
  end

  private

  def find_managers
    @managers = current_user.client.managers.where(id: params[:manager_id].split(','))
  end

end
