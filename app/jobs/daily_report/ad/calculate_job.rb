class DailyReport::Ad::CalculateJob < ApplicationJob
  queue_as :daily_ad_report

  def perform(ad_id, time)
    ad = ::Ad.find_by_id(ad_id)
    DailyReport::Ad::Calculate.new(ad, time.to_datetime).perform if ad
  end

end