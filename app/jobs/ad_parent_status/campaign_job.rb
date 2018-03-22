class AdParentStatus::CampaignJob < ApplicationJob
  queue_as :ad_parent_action

  def perform(campaign_id, action)
    campaign = Campaign.find_by_id(campaign_id)
    if campaign
      campaign.ads.find_each do |ad|
        ad.with_lock do
          ad.send(action)
        end
      end
      campaign.lock!
      campaign.send(action)
    end
  end
end
