class DailyReport::Signage::SaveToDb

  attr_reader :params, :time, :signage

  def initialize(signage, data, time)
    @signage = signage
    @params = deal_data(data)
    @time   = time
  end

  def perform
    report = DailySignageReport.find_or_create_by(created_at_date: time,
                                                  signage_id: signage.id,
                                                  shop_id: signage.shop.try(:id),
                                                  client_id: signage.client_id,
                                                  title: signage.title)
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