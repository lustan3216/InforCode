class Campaign::AdGroupInfos

  def self.update
    Campaign.all.includes(:ad_groups).each do |campaign|
      ad_groups = campaign.ad_groups
      campaign.with_lock do
        campaign.update_attributes(cost: ad_groups.sum(:cost),
                                   faces: ad_groups.sum(:faces),
                                   clicks: ad_groups.sum(:clicks),
                                   impressions: ad_groups.sum(:impressions))
      end
    end
  end

end