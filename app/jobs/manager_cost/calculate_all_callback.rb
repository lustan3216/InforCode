class ManagerCost::CalculateAllCallback
  # complete 是指全部執行過一次就觸發 success 是指全部都跑成功才觸發

  def on_complete(status, option={})
    # 這兩個變數一定要留著 不然會壞掉
    Manager::Money.check
  end

  # def on_success(status, option={})
    # 這兩個變數一定要留著 不然會壞掉
    # Manager::Budget.update
  # end
end