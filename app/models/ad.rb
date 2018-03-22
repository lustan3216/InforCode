class Ad < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include ViewMethod
  include Ad::StatusController
  include Ad::StatusValidate

  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :ad_group, optional: true
  belongs_to :campaign, optional: true
  belongs_to :client
  belongs_to :manager, optional: true, counter_cache: true
  belongs_to :ad_template, optional: true
  has_many :ads_materials
  has_many :materials, through: :ads_materials
  has_many :signage_ad_unit_contents
  has_many :ad_units, through: :signage_ad_unit_contents, source: :signage_ad_unit
  has_many :daily_ad_reports, dependent: :destroy

  delegate :name, to: :manager, prefix: true
  # validations ...............................................................
  validates_presence_of :name, :start_at, :end_at,
                        :impression_price, :face_price, :click_price,
                        :client_id, :daily_budget

  validate :start_at_and_end_at_reasonable
  # validate :same_template_size_with_material

  # callbacks .................................................................
  before_validation :assign_prices
  before_validation :set_ad_template
  before_validation :set_manager
  before_validation :clean_manager_if_is_default

  # scopes ....................................................................
  scope :not_defaults,       -> { where(is_default: false) }
  scope :defaults,           -> { where(is_default: true) }
  scope :eligible,           -> { where(status: 'eligible') }
  scope :order_position,     -> { order('signage_ad_unit_contents.position') }
  scope :same_template_size, -> (ad_unit) { joins(:ad_template).where(ad_templates: { width: ad_unit.ad_template.width, height: ad_unit.ad_template.height } ) }
  scope :fetch_defaults,     -> (ad_unit, limit = 5) { ensure_material_are_complete.same_template_size(ad_unit).defaults.order("RAND()").ensure_material_are_complete.limit(limit) }

  scope :budget_enough,          -> { self_budget_enough.manager_budget_enough.campaign_budget_enough }
  scope :self_budget_enough,     -> { where('ads.daily_budget > ads.daily_cost OR ads.daily_budget = 0') }
  scope :campaign_budget_enough, -> { left_outer_joins(:campaign).where('ads.campaign_id IS NULL OR campaigns.daily_budget > campaigns.daily_cost OR campaigns.daily_budget = 0') }
  scope :manager_budget_enough,  -> { joins(:manager).where('managers.daily_budget > managers.daily_cost OR managers.daily_budget = 0') }

  # additional config .........................................................
  acts_as_paranoid

  # class methods .............................................................
  def self.ensure_material_are_complete
    ads = all.includes(:materials).select {|ad| ad.is_material_complete?}
    ids = ads.map(&:id)
    Ad.where(id: ids)
  end

  def self.publish(for_grapejs)
    for_grapejs ? self.all : self.eligible.budget_enough
  end

  # public instance methods ...................................................
  def clean_jid
    update_columns(start_at_jid: nil, end_at_jid: nil)
  end

  def is_material_complete?
    material = materials.last
    material&.is_complete?
  end

  # protected instance methods ................................................
  # private instance methods ..................................................

  private

  def set_ad_template
    material = materials.last
    assign_attributes(ad_template_id: material.ad_template_id) if material
  end

  def assign_prices
    assign_attributes(impression_price: client.ad_impression_price || Client::DEFAULT_IMPRESSION_PRICE,
                      face_price: client.ad_face_price || Client::DEFAULT_FACE_PRICE,
                      click_price: client.ad_click_price || Client::DEFAULT_CLICK_PRICE)
  end

  def set_manager
    material = self.materials.last
    manager_id = material.manager_id if material
    assign_attributes(manager_id: manager_id)
  end

  def clean_manager_if_is_default
    assign_attributes(manager_id: nil) if is_default
  end
end