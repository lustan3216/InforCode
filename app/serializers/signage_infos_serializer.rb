class SignageInfosSerializer < ActiveModel::Serializer
  attributes :title, :sn, :shop_id, :client, :lat, :lng, :shop

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end
end