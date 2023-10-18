require 'bcrypt'

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  include BCrypt
  
  def index
    @users = User.all
  end

  def show 
  end

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User created successfully.'
    else
      flash.now[:alert] = 'Failed to save user. Please try again.'
      render :new
    end
  end

  def edit 
  end

  def update 
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated successfully.'
    else
      render :edit
    end
  end

  def destroy 
    @user.destroy
    redirect_to users_path, notice: 'User deleted successfully.'
  end


  private

  def user_params
    params.require(:user).permit(:email, :role, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
