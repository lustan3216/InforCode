class AdGroupSerializer < ActiveModel::Serializer
  include Ads::Info

  attributes :id, :client, :manager, :campaign, :ads, :clicks, :impressions,
             :faces, :cost, :name, :conv_rate, :deleted_at

  def deleted_at
    object.deleted_at&.strftime('%c')
  end

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end

  def manager
    if manager = object.manager
      "[#{manager.id}] #{manager.name}"
    end
  end

  def campaign
    if campaign = object.campaign
      "[#{campaign.id}] #{campaign.name}"
    end
  end

  def ads
    ads_info(object.ads)
  end
end