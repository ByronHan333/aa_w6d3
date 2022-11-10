class User < ApplicationRecord

  validates :username, presence: true, uniqueness: true

  has_many :artworks,
    class_name: :Artwork,
    foreign_key: :artist_id,
    dependent: :destroy

  has_many :shares,
    class_name: :ArtworkShare,
    foreign_key: :viewer_id,
    dependent: :destroy

  has_many :shared_artworks,
    through: :shares,
    source: :artwork

  has_many :comments,
    class_name: :Comment,
    foreign_key: :commenter_id,
    dependent: :destroy

  has_many :likes,
    class_name: :Like,
    foreign_key: :liker_id,
    dependent: :destroy

  has_many :collections,
    class_name: :ArtworkCollection,
    foreign_key: :collector_id,
    dependent: :destroy

  def self.favourite_artworks_for_user(id)
    user = User.find(id).artworks.where('artworks.favourite = true')
  end

  def self.favourite_shares_for_user(id)
    user = User.find(id).shared_artworks.where('artwork_shares.favourite = true')
  end

end
