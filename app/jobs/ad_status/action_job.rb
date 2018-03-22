class AdStatus::ActionJob < ApplicationJob
  queue_as :ad_action

  def perform(ad_id, action)
    ad = Ad.find_by_id(ad_id)
    if ad
      ad.with_lock do
        ad.send(action)
      end
    end
  end
end
