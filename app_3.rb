require 'bundler'
require 'rainbow'

Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
###
# Is not working ! ###


# ------------- Attention the program is in franglais ------#
puts Rainbow("------------------------------------------------").hotpink
puts Rainbow("|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |").lemonchiffon
puts Rainbow("|        Devenez l'Ace du ciel !                |").lemonchiffon
puts Rainbow("-------------------------------------------------").hotpink    
puts Rainbow("\n Quel est ton nom ?").navajowhite
    print "> "
    user_name = gets.chomp
    print "\n"
    
    my_game = Game.new(user_name)
    my_game.show_players


    while my_game.is_still_ongoing? == true
        my_game.menu
        my_game.menu_choice(gets.chomp)
        my_game.enemies_attack
    end
    my_game.end 
    
binding.pry