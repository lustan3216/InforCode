class Admin::Templates::CopiesController < Admin::TemplatesController
  before_action :find_template

  def create
    Template.where(id: params[:template_id].split(',')).each do |t|
      dup = t.dup
      dup.client_id = nil
      dup.save(validate: false)
    end

    templates = Template.all
                  .page(params[:page])
                  .order(id: :desc)

    render json: collection_json_with_message(templates, TemplateSerializer,'Copy Success')
  end

  private

  def find_template
    @template = Template.where(id: params[:template_id].split(','))
  end

end