class Admin::Reports::ShopsController < Admin::AppsController

  def index
    @shops = DailyShopReport
               .select(:shop_id, :title)
               .order(shop_id: :asc)
               .distinct
  end

  def create
    @data = DailyShopReport.where('created_at_date >= ? and created_at_date <= ? and shop_id = ?',
                                  params[:start_at].to_date,
                                  params[:end_at].to_date,
                                  params[:source_id])

    serializer = "Report::Shop::#{params[:type].capitalize}Serializer".constantize
    last_time_calculated_at = @data.last.created_at.strftime('%F %H:%M') if @data.last

    render json: { data: serialize_data(@data, serializer),
                   last_time_calculated_at: last_time_calculated_at }
  end

end
