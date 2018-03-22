class UserSerializer < ActiveModel::Serializer
  attributes :id, :client, :email, :name

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end
end