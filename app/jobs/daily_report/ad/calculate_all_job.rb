class DailyReport::Ad::CalculateAllJob < ApplicationJob
  queue_as :daily_ad_report

  def perform
    time = Time.current.to_s
    DailyAdReport.where(created_at_date: time.to_date).delete_all
    ::Ad.all.find_each do |ad|
      DailyReport::Ad::CalculateJob.perform_later(ad.id, time)
    end
  end

end