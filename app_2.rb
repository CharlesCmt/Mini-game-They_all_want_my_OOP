require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#-----------Accueil
def start
    puts "------------------------------------------------"
    puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
    puts "|Le but du jeu est d'être le dernier survivant !|"
    puts "------------------------------------------------"
end
    #-----------Init_Player
def init_player
    puts " Quel ton prénom Maverick?"
    print ">"
    @maverick = HumanPlayer.new("#{gets.chomp}")
end
#-----------Enemies
def bots
    @robots = Array.new
    @airbus = Player.new("AirbusA380")
    @boeing = Player.new("Boeing737Max")
    @robots << @airbus
    @robots << @boeing

end
#-----------Combat


def menu
    start
    init_player
    bots

    while @maverick.life > 0 || (@airbus.life > 0 && @boeing.life > 0)

        print "\n"
        puts "Quelle action souhaite tu effectuer?"
        puts "------------------------------------"
        puts "a - chercher une meilleure arme"
        puts "s - chercher à se soigner"
        puts "------------------------------------"
        puts "attaquer un joueur en vue :"
        puts "------------------------------------"
        print "0 - "
        puts @airbus.show_state
        print "1 - "
        print @boeing.show_state
        puts "------------------------------------"

        if (@airbus.life <= 0 && @boeing.life <= 0)|| @maverick.life <= 0
            break
        end
        input = gets.chomp
        @robots.each do |pnj| 
            if pnj.life <= 0
                @robots.delete(pnj.name)
            else
                pnj.attacks(@maverick)
            end
        end
        case input
        when "a"
            @maverick.search_weapon
        when "s"
            @maverick.search_health_pack
        when "0"
            @maverick.attacks(@airbus)
        when "1"
            @maverick.attacks(@boeing)
        else
            puts " APPRENDS A LIRE ZOZO"
        end
    end
    puts "La partie est fini !"
    if @maverick.life > 0
        puts "Bravo, tu as gagné"
        puts @airbus.show_state, @boeing.show_state, @maverick.show_state
    else
        puts "Looser ! Tu as perdu !"
        puts @airbus.show_state, @boeing.show_state, @maverick.show_state
    end
end
menu

binding.pry