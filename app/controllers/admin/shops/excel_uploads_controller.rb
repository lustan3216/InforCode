class Admin::Shops::ExcelUploadsController < Admin::AppsController

  def create
    file = ShopExcel.create(shop_excel_params)
    ExcelImport::ShopsJob.perform_later(file)
    render json: { message: 'Uploading please wait', status: 200 }, status: 200
  end

  private

  def shop_excel_params
    params.require(:shops).permit(:file)
  end

end
