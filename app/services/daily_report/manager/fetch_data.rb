require 'elasticsearch'

class DailyReport::Manager::FetchData
  PAGE_SIZE = 1000
  HOST      = 'http://elasticsearch.iiiiiii.com'
  SOURCE    = %w{ad_type faces_length ad_impression_price ad_calculated_faces_price ad_click_price}

  attr_reader :manager, :start_at, :end_at, :client, :size
  attr_accessor :status, :total, :from

  def initialize(manager, start_at, end_at)
    @manager  = manager
    @start_at = start_at
    @end_at   = end_at
    @client   = Elasticsearch::Client.new(host: HOST)
    @status   = check_status
    @from     = 0
    @size     = PAGE_SIZE
    @total    = 1
  end

  def perform
    search if status
  end

  def need_next_page?
    total > from
  end

  private

  def search
    result = client.search(index: index, filter_path: 'hits.hits._source,hits.total', body: search_body)
    self.total = result['hits']['total']
    self.from += size
    result
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

  def search_body
    {
      _source: SOURCE,
      from: from,
      size: size,
      query: {
        bool: {
          must: [
                  { terms: { ad_id: manager.ads.ids } },
                  { term: { default: false } },
                  { range: { '@timestamp': { gte: start_at.strftime('%FT%T%z'),
                                             lte: end_at.strftime('%FT%T%z')
                  } } }
                ]

        }
      }
    }
  end
end