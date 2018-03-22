class DailyReport::Shop::Calculate

  attr_reader :shop, :time

  def initialize(shop, time)
    @shop = shop
    @time = time
  end

  def perform
    reports = DailySignageReport.where(created_at_date: time, shop_id: shop.id)
    shop_report = DailyShopReport.find_or_create_by(created_at_date: time,
                                                    shop_id: shop.id,
                                                    client_id: shop.client_id,
                                                    title: shop.title)

    shop_report.update(
      faces: reports.sum(:faces),
      clicks: reports.sum(:clicks),
      impressions: reports.sum(:impressions),
      faces_cost: reports.sum(:faces_cost),
      clicks_cost: reports.sum(:clicks_cost),
      impressions_cost: reports.sum(:impressions_cost),
    )
  end

end
