class Artwork < ActiveRecord

  validates :title, :artist_id, presence: true,
  validates :image_url, presence: true, uniqueness: true
  validates :title, uniqueness: { scope: :artist_id }

  # belongs_to :artist,
  #   class_name: :User,
  #   foreign_key: :artist_id
end
