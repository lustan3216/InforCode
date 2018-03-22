class ContainerSerializer < ActiveModel::Serializer
  attributes :id, :client,:title, :description

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end
end