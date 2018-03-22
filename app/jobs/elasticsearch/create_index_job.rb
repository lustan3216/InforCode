class Elasticsearch::CreateIndexJob < ApplicationJob
  queue_as :elasticsearch

  def perform
    Elasticsearch::Index.set_max_result_window
    Elasticsearch::Index.create
    Elasticsearch::Index.create_tomorrow_index
  end

end