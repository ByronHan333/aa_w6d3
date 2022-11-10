class Artwork < ApplicationRecord

  validates :title, :artist_id, presence: true
  validates :image_url, presence: true, uniqueness: true
  validates :title, uniqueness: { scope: :artist_id }

  belongs_to :artist,
    class_name: :User,
    foreign_key: :artist_id,
    inverse_of: :artworks

  has_many :shares,
    class_name: :ArtworkShare,
    foreign_key: :artwork_id,
    dependent: :destroy

  has_many :comments,
    class_name: :Comment,
    foreign_key: :artwork_id,
    dependent: :destroy

  has_many :likes,
    as: :likeable

  belongs_to :collection,
    class_name: :ArtworkCollection,
    foreign_key: :collection_id,
    inverse_of: :artworks

  def self.artworks_for_user_id(user_id)
    # User.find(user_id).artworks # user owned
    # User.find(user_id).shares # user shared
    artworks = User.find(user_id).artworks + User.find(user_id).shared_artworks
    artworks.uniq
  end
end
