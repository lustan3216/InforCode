module Ad::StatusValidate

  def budget_enough?
    self_budget_enough? && manager_budget_enough? && campaign_budget_enough?
  end

  def budget_not_enough?
    !budget_enough?
  end

  def money_enough?
    manager.money_enough? if manager
  end

  def money_not_enough?
    !manager || manager.money_not_enough?
  end

  private

  # def same_template_size_with_material
  #   if materials.last
  #     unless ad_template.size_equal? materials.last.ad_template
  #       errors.add(:material_unirmart_id, 'Ad template layout size need to equal to material layout size')
  #       false
  #     end
  #   end
  # end

  def start_at_and_end_at_reasonable
    if start_at >= end_at
      errors.add(:end_at, 'end time time need to after start time')
      false
    end
  end

# state_machine
  def check_eligible_time
    start_at <= Time.current && Time.current < end_at
  end

  def check_pending_time
    start_at > Time.current
  end

  def self_budget_enough?
    daily_budget > daily_cost || daily_budget == 0
  end

  def manager_budget_enough?
    if manager
      manager.daily_budget > manager.daily_cost || manager.daily_budget == 0
    end
  end

  def campaign_budget_enough?
    if campaign
      campaign.daily_budget > campaign.daily_cost || campaign.daily_budget == 0
    else
      true
    end
  end

end