class Client::Containers::ContentsController < Client::AppsController
  skip_before_action :verify_authenticity_token
  before_action :find_container

  def show
    content = @container.contents.last

    render json: {css: content.css, html: content.html, url: content.content.url}, status: 200
  end

  def create
    content = @container.contents.create(css: params[:css],
                                         html: params[:html],
                                         content: params[:content])

    logger.info content.content.url
    render json: {message: 'Upload success'}, status: 200
  end

  private

  def find_container
    @container = current_user.client.containers.find(params[:container_id])
  end

end
