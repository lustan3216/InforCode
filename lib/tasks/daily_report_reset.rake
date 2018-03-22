namespace :daily_report do

  task reset: :environment do
    start_at = Time.new(2017, 8).to_date
    end_at = Date.current.to_date
    [*start_at..end_at].each do |date|
      Ad.all.each {|ad| DailyReport::Ad.new(ad, date).perform}
    end
  end

end
