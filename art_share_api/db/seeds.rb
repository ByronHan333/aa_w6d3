# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

ApplicationRecord.transaction do

  # Destroy tables (if desired)
  puts 'Destroying tables...'
  Artwork.destroy_all
  User.destroy_all

  # Reset primary keys
  puts 'Resetting id sequences...'
  %w(users artworks).each do |table_name|
    ApplicationRecord.connection.reset_pk_sequence!(table_name)
  end

  # Create seed data
  puts 'Creating seed data...'
  u1 = User.create!(username: 'harrison')
  u2 = User.create!(username: 'carrie')
  u3 = User.create!(username: 'sharer3')
  u4 = User.create!(username: 'sharer4')

  a1 = Artwork.create!(title: 'Star Wars', image_url: "www.google.com", artist_id: 1)
  a2 = Artwork.create!(title: 'Abc', image_url: "www.meta.com", artist_id: 2)

  as1 = ArtworkShare.create!(artwork_id: 1, viewer_id: 3)
  as2 = ArtworkShare.create!(artwork_id: 2, viewer_id: 4)


  puts 'Done!'


end
