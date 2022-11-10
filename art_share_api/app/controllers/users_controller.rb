class UsersController < ApplicationController
  def index
    if params.has_key?(:username)
      user = User.find_by(username: params[:username])
      render json: user
    else
      users = User.all
      render json: users
    end
  end

  def show
    user = User.find(params[:id])
    # user = User.find_by(id: params[:id])
    render json: user
  end

  def update
    # user = User.find(params[:id])
    user = User.find_by(id: params[:id])
    if user.nil?
      render json: {message: "user not found"}, status: unprocessable_entity
    else
      if user&.update(user_params)
        redirect_to user_url(user.id)
      else
        render json: user.errors.full_messages, status: unprocessable_entity
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.nil?
      render json: {message: "user not found"}, status: unprocessable_entity
    else
      if user.destroy
        # redirect_to user_url(user.id)
        render json: user
      else
        render json: user.errors.full_messages, status: unprocessable_entity
      end
    end
  end

  def create
    user = User.new(user_params)
    if user.nil?
      render json: {message: "user not created"}, status: 422
    else
      if user&.save!
        redirect_to user_url(user.id)
      else
        render json: user.errors.full_messages, status: 422
      end
    end
  end

  def favourite
    favourites = User.favourite_artworks_for_user(params[:id]) + User.favourite_shares_for_user(params[:id])
    render json: favourites
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
