module AdParentStatusController
  extend ActiveSupport::Concern

  included do
    state_machine :status, initial: :paused do

      event :resume do
        transition all => :eligible, if: :has_ads
      end

      event :pause do
        transition all => :paused
      end

    end
  end

  class_methods do
    AD_ACTIONS = %w{resume pause}

    AD_ACTIONS.each do |action|
      define_method :"#{action}_all" do
        all.each do |source|
          job = ('AdParentStatus::' + source.class.name + 'Job').constantize
          job.perform_later(source.id, action)
        end
      end
    end
  end

  private

  def has_ads
    ads.present?
  end

end