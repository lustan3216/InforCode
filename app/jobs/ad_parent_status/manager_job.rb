class AdParentStatus::ManagerJob < ApplicationJob
  queue_as :ad_parent_action

  def perform(manager_id, action)
    manager = ::Manager.find_by_id(manager_id)
    if manager
      manager.ads.find_each do |ad|
        ad.with_lock do
          ad.send(action)
        end
      end
      manager.lock!
      manager.send(action)
    end
  end
end
