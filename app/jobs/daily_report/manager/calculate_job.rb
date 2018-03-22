class DailyReport::Manager::CalculateJob < ApplicationJob
  queue_as :daily_manager_report

  def perform(manager_id, time)
    manager = ::Manager.find_by_id(manager_id)
    DailyReport::Manager::Calculate.new(manager, time.to_datetime).perform if manager
  end

end