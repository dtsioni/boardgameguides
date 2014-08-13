class UsersController < ApplicationController

  before_action :set_user, only:[:show, :destroy, :update, :edit]
  authorize_resource
  skip_authorize_resource only:[:show, :create, :new]
  def show
  end

  def new
    @user = User.new
  end

  def index
    #index is being used as admin control panel
    @users = User.all
    #games partial
    @games = Game.all
    #tickets partial
    @tickets = Ticket.all
  end  

  def create
    @user = User.new(user_params)
    @user.role = "author"
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html{redirect_to @user}
        flash[:success] = "Welcome!"
      else
        format.html{render :new}
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to @user}
        flash[:success] = "User was successfully updated!"
      else
        format.html { render :edit }
        flash.now[:error] = "User was not successfully updated."
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