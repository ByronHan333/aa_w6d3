class Comment < ApplicationRecord
  validates :body, :artwork_id, :commenter_id, presence: true

  belongs_to :commenter,
    class_name: :User,
    foreign_key: :commenter_id,
    inverse_of: :comments

  belongs_to :artwork,
    inverse_of: :comments

  has_many :likes,
    as: :likeable

  # class_name: :Artwork,
  # foreign_key: :artwork_id

  def self.show_comments_for_artwork(artwork_id)
    Artwork.find(artwork_id).comments
  end

  def self.show_comments_for_commenter(commenter_id)
    User.find(commenter_id).comments
  end


end
