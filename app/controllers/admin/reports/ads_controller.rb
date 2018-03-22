class Admin::Reports::AdsController < Admin::AppsController
  before_action :find_ad_group, only: [:edit, :update]

  def index
    @ads = DailyAdReport
             .select(:ad_id, :name)
             .order(ad_id: :asc)
             .distinct
  end

  def create
    @data = DailyAdReport.where('created_at_date >= ? and created_at_date <= ? and ad_id = ?',
                                params[:start_at].to_date, params[:end_at].to_date, params[:source_id])

    serializer = "Report::Ad::#{params[:type].capitalize}Serializer".constantize
    last_time_calculated_at = @data.last.created_at.strftime('%F %H:%M') if @data.last

    render json: { data: serialize_data(@data, serializer),
                   last_time_calculated_at: last_time_calculated_at }
  end

end
