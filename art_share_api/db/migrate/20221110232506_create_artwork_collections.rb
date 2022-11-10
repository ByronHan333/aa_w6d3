class CreateArtworkCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :artwork_collections do |t|
      t.references :collector, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end

    add_column :artworks, :collection_id, :bigint, default: 0, null: false, index: true, foreign_key: {to_table: :artwork_collections}
  end
end
