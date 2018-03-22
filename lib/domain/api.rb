module Domain
  class Api
    def self.matches? request
      case request.subdomain
      when 's', 'signage', 'signages'
        true
      else
        false
      end
    end
  end
end
