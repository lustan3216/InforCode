class Admin::AdGroups::ResumesController < Admin::AdGroupsController
  before_action :find_ad_groups

  def create
    @ad_groups.resume_all

    refresh_ad_groups = fetch_ad_groups
                          .page(params[:page])
                          .order(id: :desc)

    render json: collection_json_with_message(refresh_ad_groups,
                                              AdGroupSerializer,
                                              'Action performing, please wait')
  end

  private

  def find_ad_groups
    @ad_groups = AdGroup.where(id: params[:ad_group_id].split(','))
  end

end
