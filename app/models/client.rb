class Client < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  has_many :shops, dependent: :destroy
  has_many :signages, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :managers, dependent: :destroy

  has_many :containers, dependent: :destroy
  has_many :ads, dependent: :destroy
  has_many :ad_groups, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :templates, dependent: :destroy
  has_many :ad_templates, dependent: :destroy

  has_many :shop_excels, dependent: :destroy
  has_many :signage_excels, dependent: :destroy
  has_many :signage_ad_units, dependent: :destroy

  has_many :api_clients, dependent: :destroy

  has_many :daily_ad_reports, dependent: :destroy
  has_many :daily_signage_reports, dependent: :destroy
  has_many :daily_shop_reports, dependent: :destroy
  has_many :daily_manager_reports, dependent: :destroy
  # validations ...............................................................
  validates_presence_of :ad_impression_price, :ad_click_price, :ad_face_price, :title, :telephone
  before_validation :default_price

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  acts_as_paranoid
  DEFAULT_IMPRESSION_PRICE = 0.1
  DEFAULT_CLICK_PRICE = 3.0
  DEFAULT_FACE_PRICE = 1.0

  # class methods .............................................................
  # public instance methods ...................................................
  def materials
    Material.where(manager_id: managers.ids)
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  def default_price
    assign_attributes(ad_impression_price: DEFAULT_IMPRESSION_PRICE) if ad_impression_price.nil?
    assign_attributes(ad_click_price: DEFAULT_CLICK_PRICE) if ad_click_price.nil?
    assign_attributes(ad_face_price: DEFAULT_FACE_PRICE) if ad_face_price.nil?
  end
end
