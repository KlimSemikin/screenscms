class PlaylistContent < ApplicationRecord
  default_scope -> { order('position ASC') }
  belongs_to :playlist
  belongs_to :content
  acts_as_list :scope => :playlist
end
