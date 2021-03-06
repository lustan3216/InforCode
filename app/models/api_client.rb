class ApiClient < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :client

  # validations ...............................................................
  # callbacks .................................................................
  before_create do
    self.password      ||= SecureRandom.hex(16)
    self.shared_secret ||= SecureRandom.hex(16)
    self.api_key       ||= SecureRandom.hex(16)
  end

  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
