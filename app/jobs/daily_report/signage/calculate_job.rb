class DailyReport::Signage::CalculateJob < ApplicationJob
  queue_as :daily_signage_report

  def perform(signage_id, time)
    signage = ::Signage.find_by_id(signage_id)
    DailyReport::Signage::Calculate.new(signage, time.to_datetime).perform if signage
  end

end