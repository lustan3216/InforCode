class AdsCostAndSize::Calculate
  attr_reader :ad, :end_at, :clicks, :faces, :impressions,
              :clicks_price, :faces_price, :impressions_price, :data

  def initialize(ad)
    @ad                = ad
    @end_at            = Time.current
    @data              = source_data

    @clicks_price      = 0
    @faces_price       = 0
    @impressions_price = 0

    @faces             = 0
    @clicks            = 0
    @impressions       = 0

    analyse_data
  end

  def update_info
    AdsCostAndSize::InfoData.new(self).update
  end

  private

  def source_data
    data = AdsCostAndSize::FetchData.new(ad, end_at).fetch_data
    data && data['hits']
  end

  def analyse_data
    each_source do |source|
      case source['ad_type']
      when 'Impression'
        @impressions       += 1
        @impressions_price += source['ad_impression_price'].to_f
        @faces_price       += source['ad_calculated_faces_price'].to_f
        @faces             += source['faces_length'].to_i
      when 'Click'
        @clicks            += 1
        @clicks_price      += source['ad_click_price'].to_f
      end
    end
  end

  def each_source
    if data && data['hits']
      data['hits'].each do |_source|
        source = _source['_source']
        yield source
      end
    end
  end
end