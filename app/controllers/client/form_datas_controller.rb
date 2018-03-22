class Client::FormDatasController < Client::AppsController

  def ads
    _ads = Ad.where(manager_id: params[:manager_id])
    _ads = _ads.where(ad_template_id: params[:ad_template_id]) if params[:ad_template_id]

    render json: _ads.select(:id, :name).as_json
  end

  def ad_groups
    _ad_groups = AdGroup.where(manager_id: params[:manager_id])

    render json: _ad_groups.select(:id, :name).as_json
  end

end
