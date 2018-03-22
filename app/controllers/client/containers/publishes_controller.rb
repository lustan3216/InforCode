class Client::Containers::PublishesController < Client::AppsController

  def create
    containers = current_user.client.containers.where(id: params[:container_id].split(','))
    messages = if containers.present?
                 'Publish done' if containers.publish_all
               end
  rescue
    messages = 'Publish fail'
  ensure
    render json: { message: messages },status: 200
  end

end
