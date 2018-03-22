class Push::ContainerJob < ApplicationJob
  queue_as :push

  def perform(container_id)
    container = Container.find_by_id(container_id)

    if container
      container.publish
      Rpush.push
    end
  end
end
