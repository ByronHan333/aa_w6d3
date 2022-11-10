class ArtworkSharesController < ApplicationController

  def create
    artwork_share = ArtworkShare.new(artwork_share_params)
    if artwork_share.nil?
      render json: {message: "artwork share not created"}, status: 422
    else
      if artwork_share.save!
        # redirect_to artwork_share_url(artwork_share.id)
        show(artwork_share.id)
      else
        render json: artwork_share.errors.full_messages, status: 422
      end
    end
  end

  def destroy
    artwork_share = ArtworkShare.find(params[:id])
    if artwork_share.nil?
      render json: {message: "artwork share not found"}, status: unprocessable_entity
    else
      if artwork_share.destroy
        # redirect_to artwork_share_url(artwork_share.id)
        render json: artwork_share
      else
        render json: artwork_share.errors.full_messages, status: unprocessable_entity
      end
    end
  end

  private
  def artwork_share_params
    params.require(:artwork_share).permit(:artwork_id, :viewer_id)
  end

  def show(id)
    artwork_share = ArtworkShare.find(id)
    render json: artwork_share
  end
end
