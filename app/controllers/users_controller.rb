class UsersController < ApplicationController
  before_action :set_user, only:[:show]

  def show
  end

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end  

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html{redirect_to @user}
      else
        format.html{render :new}
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:name, :email, :role, :rank, :password, :password_confirmation)
    end

end