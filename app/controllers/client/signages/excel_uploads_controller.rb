class Client::Signages::ExcelUploadsController < Client::AppsController

  def create
    client = current_user.client
    file = client.signage_excels.create(signage_excel_params)
    ExcelImport::SignagesJob.perform_later(file, client)
    render json: { message: 'Uploading please wait', status: 200 }, status: 200
  end

  private

  def signage_excel_params
    params.require(:signages).permit(:file)
  end
end
