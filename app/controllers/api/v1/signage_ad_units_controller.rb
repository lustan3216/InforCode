class Api::V1::SignageAdUnitsController < Api::V1::ApiController
  before_action :find_signage_ad_unit

  def show
    # script is an array, but random is not
    ads = AdUnitContent::Ads.new(@signage_ad_unit, params[:for_grapejs]).fetch

    render_200 ads,
               { mode: @signage_ad_unit.mode,
                 signage_ad_unit_id: @signage_ad_unit.id,
                 refresh_ad_second: @signage_ad_unit.refresh_ad_second,
                 refresh_script_hour: @signage_ad_unit.refresh_script_hour },
               { serializer: UnitAdsSerializer }
  end

  private

  def find_signage_ad_unit
    @signage_ad_unit = SignageAdUnit.find(params[:id])
  end
end
