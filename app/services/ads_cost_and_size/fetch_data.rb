require 'elasticsearch'

class AdsCostAndSize::FetchData
  HOST = 'http://elasticsearch.iiiiiii.com'
  SOURCE = %w{faces_length ad_impression_price ad_calculated_faces_price ad_click_price ad_type}

  attr_reader :ad, :client, :start_at, :end_at
  attr_accessor :status

  def initialize(ad, end_at)
    @ad       = ad
    @start_at = deal_start_at
    @end_at   = deal_end_at(end_at)
    @client   = Elasticsearch::Client.new(host: HOST)
    @status   = check_status
  end

  def fetch_data
    search if status
  end

  private

  def search
    client.search(index: index, filter_path: 'hits.hits._source,hits.total', body: search_body)
  # rescue => e
  #   if e.to_s.include?('index_not_found_exception')
  #     result = {'hits': {'total': 0, 'hits':[]}}.as_json
  #   else
  #     raise e
  #   end
  end

  def deal_start_at
    if ad.last_time_of_calculated_at
      ad.last_time_of_calculated_at.strftime('%FT%T%z')
    end
  end

  def deal_end_at(end_at)
    end_at.strftime('%FT%T%z')
  end

  def check_status
    # client.transport.reload_connections!
    response = client.cluster.health
    status = response['status'] == 'red' ? false : true
  rescue
    status = false
  ensure
    status
  end

  def index
    start_at ? produce_index : 'ads-*'
  end

  def produce_index
    [start_at, end_at]
      .map {|time| assemble_index(time)}
      .uniq
      .join(',')
  end

  def assemble_index(time)
    "ads-#{time.to_time.utc.strftime('%F').gsub('-','.')}"
  end

  def time_range
    { lt: end_at }.merge(start_at ? { gte: start_at } : {})
  end

  def search_body
    {
      _source: SOURCE,
      size: 10000,
      query: {
        bool: {
          must: [
                    { term: { ad_id: ad.id } },
                    { term: { default: false } },
                    { range: { '@timestamp': time_range } }
                  ]
        }
      }
    }
  end
end