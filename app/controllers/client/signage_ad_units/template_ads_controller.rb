class Client::SignageAdUnits::TemplateAdsController < Client::AppsController

  def index
    respond_to do |format|
      format.js do
        @ad_template_id = params[:ad_template_id]

        if params[:signage_ad_unit_id] != '0'
          signage_ad_unit = current_user.client.signage_ad_units.find(params[:signage_ad_unit_id])
          @selected_ad_ids = signage_ad_unit.signage_ad_unit_contents.pluck(:ad_id)
        end

        @ads = current_user.client.ads
                 .not_defaults
                 .where(ad_template_id: @ad_template_id)
                 .includes(:materials)

        render 'client/signage_ad_units/template_ads/index'
      end
    end
  end

end
