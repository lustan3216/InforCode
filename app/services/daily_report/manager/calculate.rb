class DailyReport::Manager::Calculate

  attr_reader :manager, :current_time, :start_at, :end_at

  def initialize(manager, time)
    @manager      = manager
    @current_time = time
    @start_at     = time.beginning_of_day
    @end_at       = time.end_of_day
  end

  def perform
    fetch_data = DailyReport::Manager::FetchData.new(manager, start_at, end_at)
    while fetch_data.need_next_page? && fetch_data.status
      manager_data = fetch_data.perform
      counted_data = DailyReport::Manager::Count.new(manager_data)
      DailyReport::Manager::SaveToDb.new(manager, counted_data, current_time).perform
    end

  end
end
