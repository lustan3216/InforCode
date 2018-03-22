class AdTemplate < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include ViewMethod

  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :client
  has_many :ads
  has_many :materials
  has_many :signage_ad_units

  # validations ...............................................................
  validates_presence_of :client_id, :width, :height

  # callbacks .................................................................
  before_save :set_title
  before_destroy :check_ads_empty

  # scopes ....................................................................
  # additional config .........................................................
  MAX_ADS = 10

  # class methods .............................................................
  # public instance methods ...................................................
  def size_equal?(ad_template)
    width == ad_template.width && height == ad_template.height
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def set_title
    assign_attributes(title: "#{width} * #{height}") if title.blank?
  end

  def check_ads_empty
    ads.empty? && materials.empty? && signage_ad_units.empty?
  end
end
