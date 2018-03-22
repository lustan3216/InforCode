class DailyReport::Shop::CalculateJob < ApplicationJob
  queue_as :daily_shop_report

  def perform(shop_id, time)
    shop = ::Shop.find_by_id(shop_id)
    DailyReport::Shop::Calculate.new(shop, time.to_datetime).perform if shop
  end

end