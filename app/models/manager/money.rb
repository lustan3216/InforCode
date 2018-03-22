class Manager::Money

  def self.check
    Manager.all.includes(:ads).each do |manager|
      if manager.money_not_enough?
        manager.ads.eligible.find_each do |ad|
          ad.with_lock do
            ad.limit_by_money
            ad.clean_jid
          end
        end
      end
    end
  end

end