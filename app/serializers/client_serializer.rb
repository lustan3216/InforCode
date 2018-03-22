class ClientSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :telephone,
             :ad_impression_price, :ad_click_price, :ad_face_price,
             :address

  def eligible_ads_count
    object.ads.eligible.size
  end

  def address
    [object.zipcode, object.address1, object.district, object.city, object.country].reject(&:blank?).compact.join(', ')
  end
end