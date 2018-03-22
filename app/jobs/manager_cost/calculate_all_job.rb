class ManagerCost::CalculateAllJob < ApplicationJob
  queue_as :manager_cost

  def perform
    Sidekiq::Queue.new('manager_cost').clear

    batch = Sidekiq::Batch.new
    batch.on(:complete, ManagerCost::CalculateAllCallback)
    batch.jobs do
      Manager.all.find_each do |manager|
        ManagerCost::CalculateOneJob.perform_later(manager.id)
      end
    end
  end
end
