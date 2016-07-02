class UserController < ApplicationController
  def name
    if @current_user.update(name: params[:user][:name])
      render json: {name: @current_user.name}
    else
      render json: {error: @current_user.errors}, status: 501
    end
  end

  def email
    if @current_user.update(email: params[:user][:email])
      render json: {email: @current_user.email}
    else
      render json: {error: @current_user.errors}, status: 501
    end
  end
end
