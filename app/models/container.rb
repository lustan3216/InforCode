class Container < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include ViewMethod

  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  has_many :contents, class_name: 'ContainerContent', dependent: :destroy
  has_many :images, class_name: 'ContainerImage', dependent: :destroy
  has_many :signages

  belongs_to :client
  # validations ...............................................................
  validates_presence_of :title, :client_id

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  def self.publish_all
    all.each do |container|
      Push::ContainerJob.perform_later(container.id)
    end
  end

  # public instance methods ...................................................
  def publish
    signages.includes(container: :contents).each(&:publish)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
