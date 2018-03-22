class ManagerSerializer < ActiveModel::Serializer
  attributes :id, :client,:email, :status, :name, :daily_budget, :remaining_sum,
             :ads_count, :eligible_ads_count, :last_time_of_calculated_at

  def client
    client = object.client
    "[#{client.id}] #{client.title}"
  end

  def remaining_sum
    if object.remaining_sum < 0
      "<p style='color:red'>#{object.remaining_sum}</p>"
    else
      object.remaining_sum
    end
  end

  def eligible_ads_count
    object.ads.eligible.size
  end

  def last_time_of_calculated_at
    object.last_time_of_calculated_at&.strftime('%F %H:%M')
  end
end