class DailyReport::Manager::Count

  attr_reader :data, :faces, :clicks, :impressions, :faces_cost, :clicks_cost, :impressions_cost

  def initialize(data)
    @data             = data
    @faces            = 0
    @clicks           = 0
    @impressions      = 0
    @faces_cost       = 0
    @clicks_cost      = 0
    @impressions_cost = 0

    perform
  end

  def perform
    data_status && source_data.each do |source|
      count_by_type(source)
    end
  end

  private

  def count_by_type(source)
    _source = source['_source']
    send('count_'+ _source['ad_type'].downcase, _source)
  end

  def count_impression(source)
    @impressions      += 1
    @faces            += source['faces_length'].to_i
    @faces_cost       += source['ad_calculated_faces_price'].to_f
    @impressions_cost += source['ad_impression_price'].to_f
  end

  def count_click(source)
    @clicks      += 1
    @clicks_cost += source['ad_click_price'].to_f
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