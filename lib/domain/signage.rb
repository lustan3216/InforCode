module Domain
  class Signage
    def self.matches? request
      case request.subdomain
      when 'signages'
        true
      else
        false
      end
    end
  end
end
