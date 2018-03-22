class Client::AppsController < ApplicationController

  layout 'client'
  before_action :authenticate_user!
  serialization_scope :current_user

  private

  # def pundit_user
  #   current_admin
  # end
  #
  # def unauthorized
  #   # flash[:danger] = '您無此操作權限，請與最高管理者聯繫~'
  #   respond_to do |format|
  #     format.html { redirect_to client_dashboards_path, :flash => { :danger => '您無此操作權限，請與最高管理者聯繫~' } }
  #     format.json { render :json => { :flash => '您無此操作權限，請與最高管理者聯繫~' }, :status => 422 }
  #   end
  # end

end
