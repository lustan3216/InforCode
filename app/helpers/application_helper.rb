module ApplicationHelper

  def video_display(file)
    'display: none;' unless file.url.present? && file.file.filename.include?('mp4')
  end

  def file_input_accept(object)
    list = object.extension_white_list
    array = []
    list.each do |a|
      case a
      when 'mp4'  then array << 'video/mp4'
      when 'jpeg' then array << 'image/jpeg'
      when 'jpg'  then array << 'image/jpg'
      when 'gif'  then array << 'image/gif'
      when 'png'  then array << 'image/png'
      when 'js'   then array << 'text/js'
      when 'css'  then array << 'text/css'
      when 'html' then array << 'text/html'
      end
    end
    array.join(',')
  end

  def sidebar_active(controller)
    if request.params['controller'].match(/admin/)
      'active' if controller == request.params['controller'].match(/admin\/(.*)/)[1]
    elsif request.params['controller'].match(/client/)
    'active' if controller == request.params['controller'].match(/client\/(.*)/)[1]
    end
  end
end
