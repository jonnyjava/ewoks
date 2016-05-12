class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized

  def index
    users = policy_scope(User.all.page(params[:page]))
    authorize users
    @users = UserDecorator.decorate_collection(users)
  end

  def show
    authorize @user
  end

  def new
    @user = User.new
    authorize @user
  end

  def edit
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize @user

    respond_to do |format|
      if successfully_updated(params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  def regenerate_auth_token
    authorize @user
    @user.update_auth_token

    respond_to do |format|
      format.html do
        redirect_to @user, notice: 'Token was regenerated.'
      end if @user.save
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :username
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end

  private

  def set_user
    @user = User.find(secure_id)
  end

  def secure_id
    params[:id].to_i
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation,
      :current_password, :name, :surname, :country, :phone
    )
  end

  def needs_password?(params)
    params[:user][:password].present? ||
    params[:user][:password_confirmation].present?
  end

  def successfully_updated(params)
    if needs_password?(params)
      @user.update_with_password(user_params)
    else
      params[:user].delete(:current_password)
      @user.update_without_password(user_params)
    end
  end
end
