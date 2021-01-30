require 'bundler'
require 'pry'
require 'rainbow'

Bundler.require

class Game

    attr_accessor :human_player, :enemies

    def initialize(human_name)
        @enemies = Array.new
        @human_player = HumanPlayer.new(human_name)
        (1..4).each do |i| 
            @enemies << Player.new("bot#{i}")
        end
    end
    
    def kill_player(dead_bot)
            @enemies.delete(dead_bot)
    end
    
    def is_still_ongoing?
        @human_player.life > 0 && @enemies.length > 0 #Empty method return a boolean if array is empty (vide)
    end

    def show_players
        @human_player.show_state
        print "\n"
        puts "#{@enemies.count} enemies rest ! \n"
    end

    def menu
        print "\n"
        puts Rainbow("Quelle action souhaite tu effectuer?").lightsteelblue
        puts Rainbow("------------------------------------").hotpink
        puts Rainbow("a - chercher une meilleure arme").yellowgreen
        puts Rainbow("s - chercher à se soigner").olivedrab
        puts Rainbow("------------------------------------").hotpink
        puts Rainbow("attaquer un joueur en vue :").lightsteelblue
        i = 1
        @enemies.each do |ennemy|
            print "#{i} = " 
            ennemy.hp_bar
            i += 1
        end
        puts Rainbow("------------------------------------").hotpink
        print "\n> "
    end

    def menu_choice(string)
        input = string
        case input
        when "a"
            @human_player.search_weapon
        when "s"
            @human_player.search_health_pack
        when "1"
            @human_player.attacks(@enemies[0])
            if @enemies[0].life <= 0
                kill_player(@enemies[0])
            end
        when "2"
            @human_player.attacks(@enemies[1])
            if @enemies[1].life <= 0
                kill_player(@enemies[1])
            end
        when "3"
            @human_player.attacks(@enemies[2])
            if @enemies[2].life <= 0
                kill_player(@enemies[2])
            end
        when "4"
            @human_player.attacks(@enemies[3])
            if @enemies[3].life <= 0
                kill_player(@enemies[3])
            end
        else
            puts Rainbow("### APPRENDS A LIRE ZOZO ###").salmon
        end
        print "\n"
    end

    def enemies_attack
        if is_still_ongoing? == true
            @enemies.each do |pnj| 
                pnj.attacks(@human_player)
            end
        end
    end

    def end
        puts Rainbow("\nLa partie est fini !").burlywood
        
        if @human_player.life > 0
            puts Rainbow("\nBravo, tu as gagné !").forestgreen
        else
            puts Rainbow("\nLooser ! Tu as perdu !").red
        end
    end
end