class ExcelImport::ShopsJob < ApplicationJob
  queue_as :import_excel

  def perform(file, client=nil)
    file.import(client)
  end
end
