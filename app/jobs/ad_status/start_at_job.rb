class AdStatus::StartAtJob < ApplicationJob
  queue_as :ad_action

  def perform(ad_id)
    # 用job_id 比對資料庫 jid 的方式，就可以過濾掉之前舊的 scheduled
    # Use find clause first, due to filter if ad not exist when perform in case

    ad = Ad.find_by_id(ad_id)
    if ad
      if provider_job_id == ad.start_at_jid
        ad.with_lock do
          ad.to_be_eligible
        end
      end
    end
  end
end
