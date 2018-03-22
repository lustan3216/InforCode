class Admin::UsersController < Admin::AppsController
  before_action :find_user, only: [:edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json do
        @users = User.all
                   .page(params[:page])
                   .order("users.#{sorting_name} #{sorting_taxis}")
                   .ransack(id_or_name_or_email_cont_any: keyword)
                   .result(distinct: true)
                   .includes(:client)

        render json: collection_json(@users, UserSerializer)
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      flash['alert'] = @user.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      flash['alert'] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    User.where(id: params[:id].split(',')).delete_all
    @users = User.all
               .page(params[:page])
               .order(id: :desc)
               .includes(:client)

    render json: collection_json_with_message(@users, UserSerializer,'Delete Success')
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    _params = params.require(:user).permit(:client_id, :name, :email, :password, :password_confirmation)

    if _params.as_json['password'].blank?
      _params.reject!{|x| x.include?('password')}
    else
      _params
    end
  end

end
