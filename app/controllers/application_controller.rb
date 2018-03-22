class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  default_form_builder FormHelper::FormBuilder

  def sorting_name
     params[:sorting_name] || 'id'
  end

  def sorting_taxis
    params[:sorting_taxis] || 'desc'
  end

  def keyword
    params[:q] || {}
  end

  def collection_json(data, serializer, options = {})
    {
      data: serialize_data(data, serializer, options),
      pagination: {
        next_page: data.next_page,
        prev_page: data.prev_page,
        current_page: data.current_page,
        total_pages: data.total_pages,
      }
    }
  end

  def collection_json_with_message(data, serializer, message = '')
    {
      data: serialize_data(data, serializer),
      pagination: {
        next_page: data.next_page,
        prev_page: data.prev_page,
        current_page: data.current_page,
        total_pages: data.total_pages,
      },
      message: message
    }
  end

  def serialize_data(data, serializer, options = {})
    if data.respond_to?(:to_ary)
      data.map { |record| serializer.new(record, options).as_json }
    else
      serializer.new(data).as_json
    end
  end
end
