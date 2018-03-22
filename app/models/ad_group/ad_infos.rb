class AdGroup::AdInfos

  def self.update
    AdGroup.all.includes(:ads).each do |ad_group|
      ads = ad_group.ads
      ad_group.with_lock do
        ad_group.update_attributes(cost: ads.sum(:cost),
                                   faces: ads.sum(:faces),
                                   clicks: ads.sum(:clicks),
                                   impressions: ads.sum(:impressions))
      end
    end
  end

end