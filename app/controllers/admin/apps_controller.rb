class Admin::AppsController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!

  private

  # def pundit_user
  #   current_admin
  # end
  #
  # def unauthorized
  #   # flash[:danger] = '您無此操作權限，請與最高管理者聯繫~'
  #   respond_to do |format|
  #     format.html { redirect_to admin_dashboards_path, :flash => { :danger => '您無此操作權限，請與最高管理者聯繫~' } }
  #     format.json { render :json => { :flash => '您無此操作權限，請與最高管理者聯繫~' }, :status => 422 }
  #   end
  # end

end
