class Client::AdGroups::PausesController < Client::AdGroupsController
  before_action :find_ad_groups

  def create
    @ad_groups.pause_all

    refresh_ad_groups = fetch_ad_groups
                          .page(params[:page])
                          .order(id: :desc)

    render json: collection_json_with_message(refresh_ad_groups,
                                              AdGroupSerializer,
                                              'Action performing, please wait')
  end

  private

  def find_ad_groups
    @ad_groups = current_user.client.ad_groups.where(id: params[:ad_group_id].split(','))
  end

end
