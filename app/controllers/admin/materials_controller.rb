class Admin::MaterialsController < Admin::AppsController
  before_action :find_material, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @materials = fetch_materials
                       .page(params[:page])
                       .order("materials.#{sorting_name} #{sorting_taxis}")
                       .ransack(id_or_name_cont_any: keyword)
                       .result(distinct: true)

        render json: collection_json(@materials, MaterialSerializer)
      end
    end
  end

  def new
    @material = Material.new
  end

  def create
    respond_to do |format|
      format.html do
        @material = Material.new(material_params)
        if @material.save
          redirect_to admin_materials_path
        else
          flash['alert'] = @material.errors.full_messages
          render :new
        end
      end
      format.js do
        @material = Material.create(material_params)
        @errors = @material.errors.full_messages
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      format.html do
        if @material.update(material_params)
          redirect_to admin_materials_path
        else
          flash['alert'] = @material.errors.full_messages
          render :edit
        end
      end
      format.js do
        @material.update(material_params)
        @errors = @material.errors.full_messages
      end
    end
  end

  def destroy
    Material.where(id: params[:id].split(',')).delete_all

    @materials = fetch_materials
                   .page(params[:page]).order(id: :desc)

    render json: collection_json_with_message(@materials,
                                              MaterialSerializer,'Delete Success')
  end

  private

  def find_material
    @material = fetch_materials.find(params[:id])
  end

  def fetch_materials
    Material.with_deleted.all
      .includes(:ad_template, :manager, ads: [:manager, :materials, :campaign])
  end

  def material_params
    params.require(:material).permit(:client_id, :name, :manager_id, :ad_template_id, :trigger_file,
                                     :display_file, :buffering_file, :arrive_url)
  end

end
