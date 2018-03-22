class Client::Reports::SignagesController < Client::AppsController

  def index
    @signages = current_user
                  .client
                  .daily_signage_reports
                  .select(:signage_id, :title)
                  .order(signage_id: :asc)
                  .distinct
  end

  def create
    shop_id = Signage.find(params[:source_id]).shop.id
    @data = DailySignageReport.where('created_at_date >= ? and created_at_date <= ? and signage_id = ? and shop_id = ?',
                                     params[:start_at].to_date,
                                     params[:end_at].to_date,
                                     params[:source_id],
                                     shop_id)

    serializer = "Report::Signage::#{params[:type].capitalize}Serializer".constantize
    last_time_calculated_at = @data.last.created_at.strftime('%F %H:%M') if @data.last

    render json: { data: serialize_data(@data, serializer),
                   last_time_calculated_at: last_time_calculated_at }
  end

end
