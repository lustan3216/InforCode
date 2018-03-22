class Admin::SignageDebugs::ApksController < Admin::AppsController

  def index
  end

  def create
    json = JSON.parse(params[:json_data])
    Signage.where(id: params[:signage_id]).each do |s|
      s.custom_publish(json)
    end

    Rpush.push
    redirect_to admin_signages_path

  rescue => e
    flash['alert'] = e
    render :index
  end

end
