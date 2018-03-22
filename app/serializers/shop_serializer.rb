class ShopSerializer < ActiveModel::Serializer
  attributes :id, :client,:title, :address, :telephone, :signage_counts, :description

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end

  def signage_counts
    object.signages.size
  end

  def address
    [object.zipcode, object.address1, object.district, object.city, object.country].reject(&:blank?).compact.join(', ')
  end

end