class Admin::Signages::PublishesController < Admin::AppsController

  def create
    signages = Signage.where(id: params[:signage_id].split(','))
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
