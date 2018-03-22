class Cost::DailyCleanJob < ApplicationJob
  queue_as :clean_daily_cost

  def perform
    Sidekiq::Queue.new('clean_daily_budget').clear

    Ad.update_all(daily_cost: 0)
    Manager.update_all(daily_cost: 0)
    Campaign.update_all(daily_cost: 0)
  end

end