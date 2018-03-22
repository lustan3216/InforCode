module Domain
  class Adsignage
    def self.matches? request
      case request.subdomain
      when 'as', 'adsignage', 'ads'
        true
      else
        false
      end
    end
  end
end
