class SignageAdUnitSerializer < ActiveModel::Serializer
  include Ads::Info

  attributes :id, :client,:ad_template, :title, :all_ads_by_mode,
             :refresh_script_hour, :refresh_ad_second, :mode

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end

  def ad_template
    object.ad_template.try(:title)
  end

  def mode
    object.mode.titleize
  end

  def all_ads_by_mode
    _ads = case object.mode
           when 'specific' then object.ads;
           when 'random' then object.client.ads.eligible.same_template_size(object);
           end

    ads_info(_ads, scope) if _ads
  end
end