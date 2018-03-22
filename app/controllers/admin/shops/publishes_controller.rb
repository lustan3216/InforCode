class Admin::Shops::PublishesController < Admin::AppsController

  def create
    shops = Shop.where(id: params[:shop_id].split(','))
    messages = []
    shops.each do |s|
      messages << if s.signages.present?
                   "Shop:#{s.id} publish done" if shops.each { |s| s.signages.publish_all }
                 else
                   "Shop:#{s.id} has no signage"
                 end
    end
  rescue
    messages << 'Publish fail'
  ensure
    render json: { message: messages.join(' , ') },status: 200
  end

end
