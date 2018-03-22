class AdParentStatus::SignageAdUnitJob < ApplicationJob
  queue_as :ad_parent_action

  def perform(signage_ad_unit_id, action)
    signage_ad_unit = SignageAdUnit.find_by_id(signage_ad_unit_id)
    if signage_ad_unit
      signage_ad_unit.ads.find_each do |ad|
        ad.with_lock do
          ad.send(action)
        end
      end
      signage_ad_unit.lock!
      signage_ad_unit.send(action)
    end
  end
end
