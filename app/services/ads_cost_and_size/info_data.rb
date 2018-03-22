class AdsCostAndSize::InfoData
  attr_reader :info, :ad

  def initialize(info)
    @info = info
    @ad = info.ad
  end

  def update
    ad.with_lock do
      ad.tap do |x|
        x.faces           += info.faces
        x.clicks          += info.clicks
        x.impressions     += info.impressions

        x.impression_cost += info.impressions_price
        x.click_cost      += info.clicks_price
        x.face_cost       += info.faces_price
        x.cost            += ad_total_price
        x.daily_cost      += ad_total_price

        x.last_time_of_calculated_at = info.end_at
      end
      ad.save!

      campaign = ad.campaign
      if campaign
        campaign.with_lock do
          campaign.daily_cost + ad_total_price
          campaign.save!(validate: false)
        end
      end

      manager = ad.manager
      if manager
        manager.with_lock do
          # the reason why here doesn't calculate remaining sum is will cause bug where muti thread
          # to update.
          # Some ads might be update same manager at the same time
          manager.daily_cost    += ad_total_price
          manager.save!
        end
      end

    end
  end

  private

  def ad_total_price
    info.impressions_price + info.faces_price + info.clicks_price
  end

end