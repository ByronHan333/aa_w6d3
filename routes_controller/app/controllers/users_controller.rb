class UsersController < ApplicationController

  def index
    users = User.all
    render json: users
    # render plain: "I'm in the index action!"
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
    # render json: params
  end

  def create
    # @user = User.new(user_params)
    # @user.save!
    # render json: @user
    # render json: params

    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    user = User.find_by(id: params[:id])

    if user.nil?
      render json: {message:"user not found"}, status: 422
    else
      if user&.update(user_params) # shorthand for if user.exist? & user.update(user_params)
        redirect_to user_url(user.id)
      else
        # render json: {message:"user not saved"}, status: 422
        render json: user.errors.full_messages, status: 422
          # render text: "user is not found", status: 422
      end
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
