class ManagerTransactionHistorySerializer < ActiveModel::Serializer
  attributes :add_minus_money, :remaining_sum, :created_at, :deleted_at

  def created_at
    object.created_at.strftime('%c')
  end

  def deleted_at
    object.deleted_at&.strftime('%c')
  end

  def add_minus_money
    add_minus_money = object.add_minus_money
    if add_minus_money >= 0
      "+ #{add_minus_money}"
    else
      "<p style='color:red;'>- #{add_minus_money.abs}</p>"
    end
  end
end