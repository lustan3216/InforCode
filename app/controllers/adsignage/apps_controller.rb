class Adsignage::AppsController < ApplicationController

  layout 'adsignage'
  before_action :authenticate_manager!
end
