class Client::Shops::ExcelUploadsController < Client::AppsController

  def create
    client = current_user.client
    file = client.shop_excels.create(shop_excel_params)
    ExcelImport::ShopsJob.perform_later(file, client)
    render json: { message: 'Uploading please wait', status: 200 }, status: 200
  end

  private

  def shop_excel_params
    params.require(:shops).permit(:file)
  end

end
