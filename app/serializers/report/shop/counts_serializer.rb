class Report::Shop::CountsSerializer < ActiveModel::Serializer
  attributes :date, :faces, :clicks, :impressions

  def date
    object.created_at_date
  end

end