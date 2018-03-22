class ManagersCost::Calculate

  attr_reader :manager, :start_at, :end_at
  attr_accessor :data, :faces_cost, :impressions_cost, :clicks_cost

  def initialize(manager)
    @manager          = manager
    @start_at         = manager.last_time_of_calculated_at
    @end_at           = Time.current
    @faces_cost       = 0
    @clicks_cost      = 0
    @impressions_cost = 0

  end

  def perform
    fetch_data = ManagersCost::FetchData.new(manager, start_at, end_at)

    while fetch_data.need_next_page? && fetch_data.status
      self.data = fetch_data.perform
      calculate_cost
    end

    manager.with_lock do
      manager.remaining_sum -= faces_cost + impressions_cost + clicks_cost
      manager.last_time_of_calculated_at = end_at
      manager.save!
    end
  end

  private

  def calculate_cost
    data_status && source_data.each {|source| count_by_type(source)}
  end

  def count_by_type(source)
    _source = source['_source']
    send('count_'+ _source['ad_type'].downcase, _source)
  end

  def count_impression(source)
    self.faces_cost       += source['ad_calculated_faces_price'].to_f
    self.impressions_cost += source['ad_impression_price'].to_f
  end

  def count_click(source)
    self.clicks_cost += source['ad_click_price'].to_f
  end

  def data_status
    data && total_data > 0
  end

  def total_data
    hits_data['total']
  end

  def source_data
    hits_data['hits']
  end

  def hits_data
    data['hits']
  end
end
