class Admin::Reports::ManagersController < Admin::AppsController

  def index
    @managers = DailyManagerReport
                  .select(:manager_id, :name)
                  .order(manager_id: :asc)
                  .distinct
  end

  def create
    manager_id = Manager.find(params[:source_id]).id
    @data = DailyManagerReport.where('created_at_date >= ? and created_at_date <= ? and manager_id = ? and manager_id = ?',
                                     params[:start_at].to_date,
                                     params[:end_at].to_date,
                                     params[:source_id],
                                     manager_id)

    serializer = "Report::Manager::#{params[:type].capitalize}Serializer".constantize
    last_time_calculated_at = @data.last.created_at.strftime('%F %H:%M') if @data.last

    render json: { data: serialize_data(@data, serializer),
                   last_time_calculated_at: last_time_calculated_at }
  end

end
