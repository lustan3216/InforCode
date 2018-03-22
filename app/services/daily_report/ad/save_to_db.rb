class DailyReport::Ad::SaveToDb

  attr_reader :params, :time, :ad

  def initialize(ad, data, time)
    @ad     = ad
    @params = deal_data(data)
    @time   = time
  end

  def perform
    report = DailyAdReport.find_or_create_by(created_at_date: time,
                                             ad_id: ad.id,
                                             name: ad.name,
                                             client_id: ad.client_id)
    report.faces            += params['faces']
    report.clicks           += params['clicks']
    report.impressions      += params['impressions']
    report.faces_cost       += params['faces_cost']
    report.clicks_cost      += params['clicks_cost']
    report.impressions_cost += params['impressions_cost']
    report.save
  end

  private

  def deal_data(data)
    json = data.as_json
    json.delete('data')
    json['impressions_cost'] = json['impressions_cost'].round(1)
    json
  end

end