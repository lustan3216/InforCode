class Admin < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
