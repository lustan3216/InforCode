class AdCost::CalculateAllJob < ApplicationJob
  queue_as :ad_cost

  def perform
    Sidekiq::Queue.new('ad_cost').clear

    batch = Sidekiq::Batch.new
    batch.on(:complete, AdCost::CalculateAllCallback)
    batch.jobs do
      Ad.all.find_each do |ad|
        AdCost::CalculateOneJob.perform_later(ad.id)
      end
    end
  end
end
