class DailyReport::Signage::CalculateAllJob < ApplicationJob
  queue_as :daily_signage_report

  def perform

    batch = Sidekiq::Batch.new
    batch.on(:complete, DailyReport::Signage::CalculateAllCallback)
    batch.jobs do
      time = Time.current.to_s
      DailySignageReport.where(created_at_date: time.to_date).delete_all
      ::Signage.all.find_each do |signage|
        DailyReport::Signage::CalculateJob.perform_later(signage.id, time)
      end
    end

  end

end