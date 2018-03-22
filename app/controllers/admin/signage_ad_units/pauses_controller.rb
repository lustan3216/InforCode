class Admin::SignageAdUnits::PausesController < Admin::AppsController
  before_action :find_signage_ad_units

  def create
    @signage_ad_units.pause_all

    refresh_signage_ad_units = SignageAdUnit.all
                                 .page(params[:page])
                                 .order(id: :desc)
                                 .includes(:client, :ad_template ,ads: [:manager, :materials, :campaign])

    render json: collection_json_with_message(refresh_signage_ad_units,
                                              SignageAdUnitSerializer,
                                              'Action performing, please wait')
  end

  private

  def find_signage_ad_units
    @signage_ad_units = SignageAdUnit.where(id: params[:signage_ad_unit_id].split(','))
  end

end
