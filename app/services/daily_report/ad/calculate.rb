class DailyReport::Ad::Calculate

  attr_reader :ad, :start_at, :end_at, :current_time

  def initialize(ad, time)
    @ad              = ad
    @current_time    = time
    @start_at        = time.beginning_of_day
    @end_at          = time.end_of_day
  end

  def perform
    fetch_data = DailyReport::Ad::FetchData.new(ad, start_at, end_at)

    while fetch_data.need_next_page? && fetch_data.status
      ad_data = fetch_data.perform
      counted_data = DailyReport::Ad::Count.new(ad_data)
      DailyReport::Ad::SaveToDb.new(ad, counted_data, current_time).perform
    end
  end

end
