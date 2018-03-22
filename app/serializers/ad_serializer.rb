class AdSerializer < ActiveModel::Serializer
  attributes :id, :client, :manager, :material, :ad_template, :clicks, :impressions,
             :faces, :cost, :name, :status, :default, :daily_budget, :daily_cost,
             :end_at, :last_time_of_calculated_at, :deleted_at

  def end_at
    object.end_at.strftime('%y-%m-%d %R')
  end

  def deleted_at
    object.deleted_at&.strftime('%c')
  end

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end

  def status
    object.status.titleize
  end

  def default
    if object.is_default
      '<i style="padding-left: 15px;" class="fa fa-check" aria-hidden="true"></i>'
    end
  end

  def manager
    manager = object.manager
    "[#{manager.id}] #{manager.name}" if manager
  end

  def material
    object.materials.last.try(:name)
  end

  def ad_template
    object.ad_template.try(:title)
  end

  def last_time_of_calculated_at
    object.last_time_of_calculated_at&.strftime('%F %H:%M')
  end
end