class CampaignSerializer < ActiveModel::Serializer
  include Ads::Info
  attributes :id, :client,:manager, :ads, :clicks, :impressions,
             :faces, :cost, :name, :daily_budget, :deleted_at

  def deleted_at
    object.deleted_at&.strftime('%c')
  end

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end

  def manager
    manager = object.manager
    "[#{manager.id}] #{manager.name}" if manager
  end

  def ads
    ads_info(object.ads)
  end
end