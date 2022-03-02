class CreatePlaylistContents < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_contents do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :content, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
