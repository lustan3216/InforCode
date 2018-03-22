module Admin::AdsHelper

  def ad_image(type, ad)
    ad = ad.materials.last
    if ad
      url = ad.send("#{type}_file").url
      if url&.include?('mp4')
        content_tag(:h6, "#{type}_file".humanize) +
          video_tag(url, style: 'max-height: 200px; max-width: 200px;', controls: true)
      elsif url
        content_tag(:h6, "#{type}_file".humanize) +
          image_tag(url, style: 'max-height: 200px; max-width: 200px;')
      end
    end
  end


end
