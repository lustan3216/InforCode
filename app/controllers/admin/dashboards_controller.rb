class Admin::DashboardsController < Admin::AppsController

  def index
    respond_to do |format|
      format.html do
        @click_ads = DailyAdReport.order(clicks: :desc).yesterday.limit(3)
        @face_ads  = DailyAdReport.order(faces: :desc).yesterday.limit(3)
        @cost_ads  = DailyAdReport.order('(faces_cost + clicks_cost + impressions_cost) DESC').yesterday.limit(3)
        @no_money_managers = Manager.where('remaining_sum < ?', 5000).order(remaining_sum: :asc).limit(6)
        @date_end_ads = Ad.eligible.order(end_at: :asc)
      end
      format.json do
        if params[:filter_money]
          @no_money_managers = Manager.where('remaining_sum < ?', params[:filter_money])
                                 .order(remaining_sum: :asc)
                                 .limit(6)
          render json: @no_money_managers
        else
          @date_end_ads = Ad.eligible
                            .order(end_at: :asc)
                            .where('end_at > ? and end_at < ?', params[:start_at], params[:end_at])
          render json: @date_end_ads
        end
      end
    end
  end
end
