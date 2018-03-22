class AdParentStatus::AdGroupJob < ApplicationJob
  queue_as :ad_parent_action

  def perform(ad_group_id, action)
    ad_group = AdGroup.find_by_id(ad_group_id)
    if ad_group
      ad_group.ads.find_each do |ad|
        ad.with_lock do
          ad.send(action)
        end
      end
      ad_group.lock!
      ad_group.send(action)
    end
  end
end
