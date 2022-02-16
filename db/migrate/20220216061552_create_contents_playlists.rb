class CreateContentsPlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :contents_playlists, id: false do |t|
      t.belongs_to :playlist
      t.belongs_to :content
    end
  end
end
