class Client::Signages::PublishesController < Client::AppsController

  def create
    signages = current_user.client.signages.where(id: params[:signage_id].split(','))
    messages = if signages.present?
                 'Publish done' if signages.publish_all
               end

    Rpush.push
  rescue
    messages = 'Publish fail'
  ensure
    render json: { message: messages },status: 200
  end

end
