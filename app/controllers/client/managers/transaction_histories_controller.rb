class Client::Managers::TransactionHistoriesController < Client::AppsController

  def show
    manager = current_user.client.managers.find(params[:manager_id])
    histories = manager.transaction_histories
                  .page(params[:page])
                  .order(created_at: :desc)

    render json: collection_json(histories, ManagerTransactionHistorySerializer)
  end

end
