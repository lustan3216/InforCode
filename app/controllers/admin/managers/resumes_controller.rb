class Admin::Managers::ResumesController < Admin::AppsController
  before_action :find_managers

  def create
    @managers.resume_all

    refresh_managers = Manager.all
                         .page(params[:page])
                         .order(id: :desc)
                         .includes(:client, :ads)

    render json: collection_json_with_message(refresh_managers,
                                              ManagerSerializer,
                                              'Action performing, please wait')
  end

  private

  def find_managers
    @managers = Manager.where(id: params[:manager_id].split(','))
  end

end
