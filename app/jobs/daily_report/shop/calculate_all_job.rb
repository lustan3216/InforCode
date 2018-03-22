class DailyReport::Shop::CalculateAllJob < ApplicationJob
  queue_as :daily_shop_report

  def perform
    time = Time.current.to_s
    DailyShopReport.where(created_at_date: time.to_date).delete_all
    ::Shop.all.find_each do |shop|
      DailyReport::Shop::CalculateJob.perform_later(shop.id, time)
    end
  end

end