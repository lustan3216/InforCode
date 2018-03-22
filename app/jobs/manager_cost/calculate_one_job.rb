class ManagerCost::CalculateOneJob < ApplicationJob
  queue_as :manager_cost

  def perform(manager_id)
    manager = Manager.find_by_id(manager_id)
    ManagersCost::Calculate.new(manager).perform if manager
  end
end