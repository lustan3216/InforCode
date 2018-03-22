module Ads::Info

  def ads_info(ads, scope=nil)

    ads.reduce('') do |result, ad|
      ad_string = "[#{ad.id}] [#{ad.status.titleize}] #{ad.name}"

      unless ad.is_material_complete?
        ad_string = "<a href='#{scope_url_prefix(scope)}/ads/#{ad.id}/edit'>#{ad_string}<span style='color:red'> - Material is imcomplete</span></a>"
      end

      index = ad_string.index(ad.name) + ad.name.length
      if ad.budget_not_enough?
        ad_string.insert(index, "<span style='color:red'> - No Budget</span>")
      end

      if ad.money_not_enough?
        ad_string.insert(index, "<span style='color:red'> - No Money</span>")
      end

      ad_string += material_string(ad)

      result += "<p style='margin-bottom:0;'>#{ad_string}</p><hr>"
    end
  end

  def material_string(ad)
    material = ad.materials.last
    trigger_file_url = material&.trigger_file&.url
    display_file_url = material&.display_file&.url

    "<div class='row'>
      <div class='col-xs-5 #{'hidden' unless trigger_file_url}'>
        <h6>Trigger File</h6>
        #{appendSource(material&.trigger_file)}
      </div>
      <div class='col-xs-5 col-xs-offset-1 #{'hidden' unless display_file_url}'>
        <h6>Display File</h6>
        #{appendSource(material&.display_file)}
      </div>
    </div>"
  end

  def appendSource(source)
    if source&.file&.filename&.include?('mp4')
      "<video src='#{source}' controls style='max-height: 200px; max-width: 200px;'></video>"
    else
      "<img src='#{source}' style='max-height: 200px; max-width: 200px;'>"
    end

  end

  def scope_url_prefix(scope)
    '/admin' if scope && scope.class.name == 'Admin'
  end
end