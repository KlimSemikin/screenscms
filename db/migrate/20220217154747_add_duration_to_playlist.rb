class AddDurationToPlaylist < ActiveRecord::Migration[7.0]
  def change
    add_column :playlists, :duration, :bigint, default: 3600
  end
end
