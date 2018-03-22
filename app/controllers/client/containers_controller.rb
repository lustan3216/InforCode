class Client::ContainersController < Client::AppsController

  before_action :find_container, only: [:show, :edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @containers = current_user.client.containers
                        .page(params[:page])
                        .order("containers.#{sorting_name} #{sorting_taxis}")
                        .ransack(id_or_title_or_description_cont_any: keyword)
                        .result(distinct: true)

        render json: collection_json(@containers, ContainerSerializer)
      end
    end
  end

  def show; end

  def new
    @container = current_user.client.containers.new
  end

  def create
    @container = current_user.client.containers.new(container_params)
    if @container.save
      redirect_to client_containers_path
    else
      flash['alert'] = @container.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @container.update(container_params)
      redirect_to client_containers_path
    else
      flash['alert'] = @container.errors.full_messages
      render :edit
    end
  end

  def destroy
    current_user.client.containers.where(id: params[:id].split(',')).destroy_all
    @containers = current_user.client.containers.page(params[:page]).order(id: :desc)
    render json: collection_json_with_message(@containers, ContainerSerializer,'Delete Success')
  end

  private

  def find_container
    @container = current_user.client.containers.find(params[:id])
  end

  def container_params
    params.require(:container).permit(:title, :description)
  end

end
