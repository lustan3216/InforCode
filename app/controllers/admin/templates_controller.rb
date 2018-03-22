class Admin::TemplatesController < Admin::AppsController
  before_action :find_template, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @templates = Template.all
                       .page(params[:page])
                       .order("templates.#{sorting_name} #{sorting_taxis}")
                       .ransack(id_or_name_cont_any: keyword)
                       .result(distinct: true)
                       .includes(:client)

        render json: collection_json(@templates, TemplateSerializer)
      end
    end
  end

  def new
    @template = Template.new
  end

  def create
    @template = Template.new(template_params)
    if @template.save
      redirect_to admin_templates_path
    else
      flash['alert'] = @template.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @template.update(template_params)
      redirect_to admin_templates_path
    else
      flash['alert'] = @template.errors.full_messages
      render :edit
    end
  end

  def destroy
    Template.all.where(id: params[:id].split(',')).delete_all
    @templates = Template.all
                   .page(params[:page])
                   .order(id: :desc)
                   .includes(:client)

    render json: collection_json_with_message(@templates, TemplateSerializer,'Delete Success')
  end

  private

  def find_template
    @template = Template.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:title, :description, :photo, :content, :client_id)
  end

end
