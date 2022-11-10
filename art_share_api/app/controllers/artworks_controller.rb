class ArtworksController < ApplicationController
  def index
    artworks = Artwork.artworks_for_user_id(params[:user_id])
    render json: artworks

    # user = User.find(params[:user_id])
    # artworks = user.artworks
    # render json: artworks
  end

  def show
    artwork = Artwork.find(params[:id])
    render json: artwork
  end

  def update
    artwork = Artwork.find_by(id: params[:id])
    if artwork.nil?
      render json: {message: "artwotk not found"}, status: unprocessable_entity
    else
      if artwork&.update(artwork_param)
        redirect_to artwork_url(artwork.id)
      else
        render json: artwork.errors.full_messages, status: unprocessable_entity
      end
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    if artwork.nil?
      render json: {message: "artwork not found"}, status: unprocessable_entity
    else
      if artwork.destroy
        # redirect_to artwork_url(artwork.id)
        render json: artwork
      else
        render json: artwork.errors.full_messages, status: unprocessable_entity
      end
    end
  end

  def create
    artwork = Artwork.new(artwork_param)
    if artwork.nil?
      render json: {message: "artwork not created"}, status: 422
    else
      if artwork.save!
        redirect_to artwork_url(artwork.id)
      else
        render json: artwork.errors.full_messages, status: 422
      end
    end
  end

  private
  def artwork_param
    params.require(:artwork).permit(:title, :image_url, :artist_id)
  end

end
