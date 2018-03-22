class Signage < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include ViewMethod

  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :shop, counter_cache: true, optional: true
  belongs_to :client
  belongs_to :container, optional: true
  has_many :daily_signage_reports
  has_many :signages_categories
  has_many :signage_categories, through: :signages_categories

  has_many :signages_areas
  has_many :signage_areas, through: :signages_areas

  has_many :signages_types
  has_many :signage_types, through: :signages_types
  # validations ...............................................................
  validates_presence_of :title, :client_id, :sn
  validates_uniqueness_of :sn
  validate :check_shop_legal
  validate :check_container_legal

  # callbacks .................................................................
  before_validation :clean_container, on: :update
  before_save :ensure_sn_lowercase

  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  def self.publish_all
    all.each(&:publish)
  end

  # public instance methods ...................................................

  def publish
    if token.present?
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by_name('Taiwan')
      n.registration_ids = [token]
      n.data = { command_type: 'reset',
                 apk_content: {
                   launch_activity: ''
                 }
      }
      n.save!
    end
  end

  def custom_publish(data)
    if token.present?
      n = Rpush::Gcm::Notification.new
      n.app = Rpush::Gcm::App.find_by_name('Taiwan')
      n.registration_ids = [token]
      n.data = data
      n.save!
    end
  end

  def content_url
    container.contents.last.try { content.url }
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def clean_container
    assign_attributes(container_id: nil) if client_id_changed?
  end

  def check_shop_legal
    errors[:shop_id] << "Can't find this shop" unless client.shops.find_by(id: shop_id)
  end

  def check_container_legal
    errors[:container_id] << "Can't find this container" unless client.containers.find_by(id: container_id)
  end

  def ensure_sn_lowercase
    assign_attributes(sn: sn.try(:downcase))
  end
end
