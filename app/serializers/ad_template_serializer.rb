class AdTemplateSerializer < ActiveModel::Serializer
  attributes :id, :client,:title, :description, :width, :height

  def client
    client = object.client
    "[#{client.id}] #{client.title}" if client
  end
end