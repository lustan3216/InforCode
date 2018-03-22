class Admin::AdTemplates::CopiesController < Admin::AdTemplatesController
  before_action :find_ad_template

  def create
    AdTemplate.where(id: params[:ad_template_id].split(',')).each do |t|
      dup = t.dup
      dup.client_id = nil
      dup.save(validate: false)
    end

    ad_templates = AdTemplate.all
                     .page(params[:page])
                     .order(id: :desc)

    render json: collection_json_with_message(ad_templates, AdTemplateSerializer,'Copy Success')
  end

  private

  def find_ad_template
    @ad_template = AdTemplate.where(id: params[:ad_template_id].split(','))
  end

end
