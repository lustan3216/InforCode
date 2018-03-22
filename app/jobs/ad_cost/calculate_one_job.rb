class AdCost::CalculateOneJob < ApplicationJob
  queue_as :ad_cost

  def perform(ad_id)
    ad = Ad.find_by_id(ad_id)
    ::AdsCostAndSize::Calculate.new(ad).update_info if ad
  end
end