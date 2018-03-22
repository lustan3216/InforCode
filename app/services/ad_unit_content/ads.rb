class AdUnitContent::Ads

  attr_reader :for_grapejs, :signage_ad_unit

  def initialize(signage_ad_unit, for_grapejs=false)
    @signage_ad_unit = signage_ad_unit
    @for_grapejs = for_grapejs
  end

  def fetch
    case signage_ad_unit.mode
    when 'specific'
      script_ads_prevent_defaults.includes(:materials);
    when 'random'
      random_ad_prevent_default;
    end
  end

  def script_ads
    signage_ad_unit
      .ads
      .not_defaults
      .ensure_material_are_complete
      .order_position
      .publish(for_grapejs)
  end

  def script_ads_prevent_defaults
    ads = script_ads
    if ads.present?
      ads
    else
      signage_ad_unit.client.ads.fetch_defaults(signage_ad_unit)
    end
  end

  def random_ad
    signage_ad_unit.client
      .ads
      .not_defaults
      .ensure_material_are_complete
      .same_template_size(signage_ad_unit)
      .publish(for_grapejs)
      .sample
  end

  def random_ad_prevent_default
    ad = random_ad
    if ad.present?
      ad
    else
      signage_ad_unit.client.ads.fetch_defaults(signage_ad_unit, 1).first
    end
  end

end