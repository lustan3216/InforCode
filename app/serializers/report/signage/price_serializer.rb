class Report::Signage::PriceSerializer < ActiveModel::Serializer
  attributes :date, :faces, :clicks, :impressions

  def date
    object.created_at_date
  end

  def faces
    object.faces_cost
  end

  def clicks
    object.clicks_cost
  end

  def impressions
    object.impressions_cost
  end

end