class SignageSerializer < ActiveModel::Serializer
  attributes :id, :client,:title, :sn, :token, :status, :shop, :container, :lat, :lng

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end

  def shop
    shop = object.shop
    "[#{shop.id}] #{shop.title}" if shop
  end

  def container
    container = object.container
    "[#{container.id}] #{container.title}" if container
  end
end