class Admin::Managers::TransactionHistoriesController < Admin::AppsController

  def show
    histories = ManagerTransactionHistory.with_deleted
                  .where(manager_id: params[:manager_id])
                  .page(params[:page])
                  .order(created_at: :desc)

    render json: collection_json(histories, ManagerTransactionHistorySerializer)
  end

end
