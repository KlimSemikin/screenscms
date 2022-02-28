# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user1, user2 = User.create([{ auth0_uid: 'SPHxe0IVWqfelUEv0iZe8nBVmMZoZ18M@clients' }, { auth0_uid: 'itqOmX0OLLU1nDh49wmPbd8dSH9V7Fof@clients' }])

event1, event2 = user1.events.create([{ name: 'event1' }, { name: 'event2' }])
event3, event4 = user2.events.create([{ name: 'event3' }, { name: 'event4' }])

event1.screens.create([{ name: 'screen1' }, { name: 'screen2' }])
event2.screens.create([{ name: 'screen3' }, { name: 'screen4' }])
event3.screens.create([{ name: 'screen5' }, { name: 'screen6' }])
event4.screens.create([{ name: 'screen7' }, { name: 'screen8' }])

screens = Screen.all
screens.each(&:create_playlist)

file = File.open('200w.gif')
content = Content.create(content: file)

playlists = Playlist.all
playlists.each do |playlist|
  playlist.contents << content
  playlist.contents << content
end
