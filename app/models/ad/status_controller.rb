module Ad::StatusController
  extend ActiveSupport::Concern

  included do
    state_machine :status, initial: :paused do
      event :resume do
        transition all => :eligible, if: [:check_eligible_time, :money_enough?]
        transition all => :pending, if: [:check_pending_time, :money_enough?]
        transition all => :limited_by_money, if: [:money_not_enough?]
        transition all => :time_error
      end

      event :to_be_eligible do
        transition pending: :eligible, if: [:money_enough?]
        transition pending: :limited_by_money, if: [:money_not_enough?]
      end

      event :pause do
        transition [:eligible, :pending] => :paused
      end

      event :date_end do
        transition eligible: :date_ended
      end

      event :limit_by_money do
        transition [:eligible, :pending] => :limited_by_money, if: [:money_not_enough?]
      end

      after_transition any => [:date_ended, :limited_by_money, :pause, :time_error] do |ad, transition|
        ad.update(start_at_jid: nil, end_at_jid: nil)
      end

      after_transition any => :eligible do |ad, transition|
        end_jid = AdStatus::EndAtJob.set(wait_until: ad.end_at).perform_later(ad.id).provider_job_id
        # 每次轉成 eligible 就清掉start_jid 因為是即時的，並儲存 end_jid 讓之後每次 scheduled 執行的 jid 要先等於儲存的jid

        ad.update(start_at_jid: nil, end_at_jid: end_jid)
      end

      after_transition any => :pending do |ad, transition|
        start_jid = AdStatus::StartAtJob.set(wait_until: ad.start_at).perform_later(ad.id).provider_job_id
        # 每次轉成 pending 就儲存 start_jid / end_jid 讓之後每次 scheduled 執行的 jid 要先等於儲存的jid
        ad.update(start_at_jid: start_jid, end_at_jid: nil)
      end

    end
  end

  class_methods do
    AD_ACTIONS = %w{resume pause}

    AD_ACTIONS.each do |action|
      define_method :"#{action}_all" do
        all.each do |source|
          AdStatus::ActionJob.perform_later(source.id, action)
        end
      end
    end
  end

end