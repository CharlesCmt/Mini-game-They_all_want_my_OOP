require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

Airbus = Player.new("AirbusA380")
Boeing = Player.new("Boeing737Max")
puts "Voici l'état de leur avion:"
Airbus.show_state
Boeing.show_state
puts "Allez bombardex l'ennemi!"
while Airbus.life > 0 && Boeing.life > 0
    Airbus.attacks(Boeing)
    if Airbus.life <= 0 || Boeing.life <= 0
        break
    end
    Boeing.attacks(Airbus)
end


binding.pry