class Material < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................
  include ViewMethod

  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :manager, optional: true
  belongs_to :ad_template

  has_many :ads_materials
  has_many :ads, through: :ads_materials

  # validations ...............................................................
  validates_presence_of :ad_template_id, :name

  # callbacks .................................................................
  after_commit :set_ad_ad_template

  # scopes ....................................................................
  # additional config .........................................................
  acts_as_paranoid

  mount_uploader :trigger_file, Material::TriggerUploader
  mount_uploader :display_file, Material::DisplayUploader
  mount_uploader :buffering_file, Material::BufferingUploader
  # class methods .............................................................
  # public instance methods ...................................................
  def is_complete?
    trigger_file.present? && display_file.present?
  end

  def id_with_name_and_size
    "[#{id}] [#{ad_template.title}] #{name}"
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
  private

  def set_ad_ad_template
    if previous_changes[:ad_template_id]
      ads.update_all(ad_template_id: ad_template_id)
    end
  end
end
