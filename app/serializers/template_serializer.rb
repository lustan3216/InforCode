class TemplateSerializer < ActiveModel::Serializer
  attributes :id, :client,:title, :description, :photo_url, :content

  def client
    client = object.client
    "[#{client.id}] #{client.title}" if client
  end

  def photo_url
    object.photo.url
  end
end