class UsersController < ApplicationController
  before_action :set_user, only:[:show, :destroy]

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
    @user.role = "author"
    respond_to do |format|
      if @user.save
        redirect_to @user
      else
       render 'new'
      end
    end
  end

  def destroy
    name = @user.name
    @user.destroy
    respond_to do |format|
      format.html{redirect_to users_path, notice: "#{name} was successfully destroyed."}
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