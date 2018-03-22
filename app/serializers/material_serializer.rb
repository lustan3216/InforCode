class MaterialSerializer < ActiveModel::Serializer
  include Ads::Info

  attributes :id, :name, :manager, :ads, :ads_count, :ad_template,
             :trigger_file, :display_file, :arrive_url, :updated_at, :deleted_at

  def deleted_at
    object.deleted_at&.strftime('%c')
  end

  def updated_at
    object.updated_at.strftime('%c')
  end

  def manager
    manager = object.manager
    "[#{manager.id}] #{manager.name}" if manager
  end

  def trigger_file
    if object.trigger_file_url.present?
      case object.trigger_file.file.extension
      when 'mp4'
        '<video controls style="height:50px;" src="' + object.trigger_file_url + '"></video>'
      else
        '<img style="height:50px;" src="' + object.trigger_file_url + '">'
      end
    end
  end

  def buffering_file
    if object.buffering_file.present?
      '<img style="height:50px;" src="' + object.buffering_file_url + '">'
    end
  end

  def display_file
    if object.display_file_url.present?
      case object.display_file.file.extension
      when 'mp4'
        '<video controls style="height:50px;" src="' + object.display_file_url + '"></video>'
      else
        '<img style="height:50px;" src="' + object.display_file_url + '">'
      end

    end
  end

  def arrive_url
    if object.display_file.present?
      '<a>' + object.arrive_url + '</a>'
    end
  end

  def ads_count
    object.ads.size
  end

  def ads
    ads_info(object.ads, scope)
  end

  def ad_template
    ad_template = object.ad_template
    "[#{ad_template.id}] #{ad_template.title}"
  end
end