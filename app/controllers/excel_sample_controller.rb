class ExcelSampleController < ApplicationController

  def signages
    send_file(
      "#{Rails.root}/public/excel_sample/signages_sample.xlsx",
      filename: "signages_sample.xlsx",
      type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )
  end

  def shops
    send_file(
      "#{Rails.root}/public/excel_sample/shops_sample.xlsx",
      filename: "shops_sample.xlsx",
      type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )
  end

end
