class DailyReport::Manager::CalculateAllJob < ApplicationJob
  queue_as :daily_manager_report

  def perform

    time = Time.current.to_s
    DailyManagerReport.where(created_at_date: time.to_date).delete_all

    ::Manager.all.find_each do |manager|
      DailyReport::Manager::CalculateJob.perform_later(manager.id, time)
    end

  end

end