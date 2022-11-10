class ArtworkCollection < ApplicationRecord
  has_many :artworks,
    class_name: :Artwork,
    foreign_key: :collection_id,
    dependent: :destroy

  belongs_to :collector,
    class_name: :User,
    foreign_key: :collector_id,
    inverse_of: :collections
end
