class Client::Containers::ImagesController < Client::AppsController
  skip_before_action :verify_authenticity_token
  before_action :find_container

  def show
    render json: {data: serialize_data(@container.images, ContainerImageSerializer)}
  end

  def create
    params[:files].each {|x| @container.images.create(image: x)}
    render json: {data: serialize_data(@container.images, ContainerImageSerializer)}
  end

  def destroy
    @container.images.find_by_image(params[:src].split('/')[-1]).delete
  end

  private

  def find_container
    @container = current_user.client.containers.find(params[:container_id])
  end

end
