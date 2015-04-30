class UsersController < ApplicationController
  
  layout "application"
  #before_filter :require_login, :except => [:forgot_password]
  before_filter :find_user, :except => [:index, :new, :create, :inactive, :forgot_password, :edit_password]

  def index
   @users = User.where(:status => 1)
   @users = @users.search(params[:search]).order("username").page(params[:page]).per(3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.registration_confirmation(@user).deliver  
      redirect_to users_path, :notice => "Created New User!"
    else
      flash[:notice] = 'please enter valid details'
      render "new"
    end
  end

  def show
  end
  
  def edit
  end

  
  def update
      @user.update_attributes(params[:user])
      if @user.save
        UserMailer.change_password_confirmation(@user).deliver  
        redirect_to users_path(@user), :notice => "Updated"
      else
      render "edit"
    end
  end

  def edit_password
   if request.get?
   else
    if params[:password] != "" and params[:password_confirmation] != ""
        current_user.password = params[:password]
        current_user.password_confirmation = params[:password_confirmation]
        if  current_user.password == current_user.password_confirmation
          if current_user.save
           flash[:notice] = 'Your password has been changed'
            redirect_to customers_path
          end
        else
          flash[:notice] = 'Your password and password confirmation must match'
        end
     
    else
      flash[:notice] = 'Your password and password confirmation must match'
    end
      
   end


      
end
    
  def forgot_password
     if request.get?      
      else
       @user = User.find_by_email(params[:email])
       @user.password = rand(99999)
       if @user.save
        UserMailer.forgot_password_confirmation(@user).deliver  
        redirect_to root_url, :notice => "Your password is Send to Registered email id"
      else
        flash[:notice] = 'Invalid email-id'
        render "forgot_password"
     end
    end
  end
  

  def destroy
    @user.destroy
    redirect_to users_path
  end

def activate
    @user.activate
    redirect_to inactive_users_path
  end
  

  def deactive
    @user.deactive
    redirect_to users_path
  end


def inactive
   @users = User.where(:status => 0)
   @users = @users.search(params[:search]).order("username").page(params[:page]).per(3)
end

private
  def find_user
    @user = User.find(params[:id])
    if not @user
      raise  ActiveRecord::RecordNotFound
    end
  end
end
