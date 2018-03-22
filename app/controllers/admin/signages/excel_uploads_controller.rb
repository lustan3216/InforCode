class Admin::Signages::ExcelUploadsController < Admin::AppsController

  def create
    file = SignageExcel.create(signage_excel_params)
    ExcelImport::SignagesJob.perform_later(file)
    render json: { message: 'Uploading please wait', status: 200 }, status: 200
  end

  private

  def signage_excel_params
    params.require(:signages).permit(:file)
  end
end
