class SessionsController < ApplicationController

  def new
  end

  def create
    #pulls user out of database using submitted email
    user = User.find_by(email: params[:session][:email].downcase)
    #if the user exists && the password is correct
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
      flash[:success] = "Welcome!"
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
  
end
