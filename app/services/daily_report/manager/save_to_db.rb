class DailyReport::Manager::SaveToDb

  attr_reader :params, :time, :manager

  def initialize(manager, data, time)
    @manager = manager
    @params = deal_data(data)
    @time   = time
  end

  def perform
    report = DailyManagerReport.find_or_create_by(created_at_date: time,
                                                  manager_id: manager.id,
                                                  client_id: manager.client_id,
                                                  name: manager.name)
    report.faces            += params['faces']
    report.clicks           += params['clicks']
    report.impressions      += params['impressions']
    report.faces_cost       += params['faces_cost']
    report.clicks_cost      += params['clicks_cost']
    report.impressions_cost += params['impressions_cost']
    p report
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