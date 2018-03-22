class Manager < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include AdParentStatusController
  include ViewMethod

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :client
  has_many :campaigns, dependent: :destroy
  has_many :ads, dependent: :destroy
  has_many :ad_groups, dependent: :destroy
  has_many :transaction_histories, class_name: 'ManagerTransactionHistory', dependent: :destroy
  has_many :materials, dependent: :destroy

  # validations ...............................................................
  validates_presence_of :remaining_sum, :name, :client_id, :daily_budget

  # callbacks .................................................................
  after_commit :produce_transaction_history

  # scopes ....................................................................
  # additional config .........................................................
  ransacker :daily_budget do
    Arel.sql("CONVERT(#{table_name}.daily_budget, CHAR(8))")
  end
  ransacker :remaining_sum do
    Arel.sql("CONVERT(#{table_name}.remaining_sum, CHAR(8))")
  end
  ransacker :ads_count do
    Arel.sql("CONVERT(#{table_name}.ads_count, CHAR(8))")
  end
  ransacker :running_ad_counts do
    Arel.sql("CONVERT(#{table_name}.running_ad_counts, CHAR(8))")
  end

  # class methods .............................................................
  # public instance methods ...................................................
  def money_enough?
    remaining_sum > 0
  end

  def money_not_enough?
    remaining_sum <= 0
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def produce_transaction_history
    if saved_change_to_remaining_sum
      money_was, money_now = saved_change_to_remaining_sum
      transaction_histories.create(add_minus_money: money_now.to_i - money_was.to_i,
                                   remaining_sum: money_now.to_i)
    end
  end
end