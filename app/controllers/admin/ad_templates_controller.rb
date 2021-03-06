class Admin::AdTemplatesController < Admin::AppsController
  before_action :find_ad_template, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @ad_templates = AdTemplate.all
                          .page(params[:page])
                          .order("ad_templates.#{sorting_name} #{sorting_taxis}")
                          .ransack(id_or_title_or_description_cont_any: keyword)
                          .result(distinct: true)
                          .includes(:client)

        render json: collection_json(@ad_templates, AdTemplateSerializer)
      end
    end
  end

  def new
    @ad_template = AdTemplate.new
  end

  def create
    @ad_template = AdTemplate.new(ad_template_params)
    if @ad_template.save
      redirect_to admin_ad_templates_path
    else
      flash['alert'] = @ad_template.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @ad_template.update(ad_template_params)
      redirect_to admin_ad_templates_path
    else
      flash['alert'] = @ad_template.errors.full_messages
      render :edit
    end
  end

  def destroy
    AdTemplate.where(id: params[:id].split(',')).destroy_all
    @ad_templates = AdTemplate.all
                      .page(params[:page])
                      .order(id: :desc)
                      .includes(:client)

    render json: collection_json_with_message(@ad_templates, AdTemplateSerializer,'Delete Success')
  end

  private

  def find_ad_template
    @ad_template = AdTemplate.find(params[:id])
  end

  def ad_template_params
    params.require(:ad_template).permit(:client_id, :title, :description, :width, :height)
  end

end
