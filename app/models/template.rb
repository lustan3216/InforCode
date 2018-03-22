class Template < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :client

  # validations ...............................................................
  validates_presence_of :title, :client_id, :content

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  mount_uploader :photo, TemplateUploader

  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end