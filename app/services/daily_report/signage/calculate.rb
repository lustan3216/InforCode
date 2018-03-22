class DailyReport::Signage::Calculate

  attr_reader :signage, :current_time, :start_at, :end_at

  def initialize(signage, time)
    @signage         = signage
    @current_time    = time
    @start_at        = time.beginning_of_day
    @end_at          = time.end_of_day
  end

  def perform
    fetch_data = DailyReport::Signage::FetchData.new(signage, start_at, end_at)

    while fetch_data.need_next_page? && fetch_data.status
      signage_data = fetch_data.perform
      counted_data = DailyReport::Signage::Count.new(signage_data)
      DailyReport::Signage::SaveToDb.new(signage, counted_data, current_time).perform
    end
  end
end
