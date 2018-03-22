module ExcelImport
  require 'roo'

  def import(client = nil)
    xlsx = Roo::Excelx.new(file.url)
    source = self.class.name.sub('Excel','').constantize
    header = xlsx.row(1)
    errors = []

    xlsx.each_row_streaming(offset: 1) do |row|
      data = compose_to_hash(header,row)
      s = source.new(data)
      s.client_id = client.id if client
      errors << row.first.coordinate.row unless s.save
    end

  rescue => e
    errors ||= []
    errors.unshift "An error of type #{e.class} happened, message is #{e.message}"
  ensure
    update(errors_log: errors.join(','))
  end

  def compose_to_hash(header,row)
    hash = {}
    header.each_with_index { |h, i| hash[h.to_sym] = row[i].value }
    hash
  end
end
