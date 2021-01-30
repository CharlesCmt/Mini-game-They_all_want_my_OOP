require 'bundler'
require 'pry'
require 'rainbow'

Bundler.require

class Player
  attr_accessor :name
  attr_accessor :life
  @@enemies = []

  def initialize(name)
    @name = name
    @life = 10
    @@enemies << self
  end

  def self.all
    return @@enemies
  end

  def show_state
    puts Rainbow("#{@name} a #{@life} points de vie").lightgreen
  end

  def hp_bar
    if @life > 0
      puts "#{@name} : |" + Rainbow("#{"X"*@life}#{" "*(10-@life)}").green + "| (#{@life}/10)"
    else
      puts "#{@name} : " + Rainbow("DEAD x.x").tomato
    end 
  end

  def gets_damage(damage)
    @life -= damage
    if @life <= 0
      puts Rainbow("#{@name} s'est crashé!").orangered
    else show_state
    end
  end

  def attacks(opponent)
    puts Rainbow("#{@name}, attaque l'avion #{opponent.name}").red
    damaged = opponent.gets_damage(compute_damage)
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level, :life

  def initialize(name)
    super(name)
    @weapon_level = 1
    @life = 100
  end

  def show_state
    puts Rainbow("#{@name} a #{@life} points de vie et une arme de niveau #{@weapon_level}").royalblue
  end

  def compute_damage
    return rand(1..6) * @weapon_level
  end

  def search_weapon
    lvl = rand(1..6)
    puts Rainbow("Tu as trouve une arme de niveau #{lvl}").gold
    if lvl > @weapon_level
      return @weapon_level = lvl
      puts Rainbow("Youhou ! elle est meilleure que ton arme actuelle : tu la prends.").goldenrod
    else
      puts Rainbow("M@*#$... elle n'est pas mieux que ton arme actuelle...").goldenrod
    end
  end

  def search_health_pack
    health_pack = rand(1..6)
    case health_pack
    when 1
      puts Rainbow("Tu n'as rien trouvé... ").salmon
    when 2..5
      puts Rainbow("Bravo, tu as trouvé un pack de +50 points de vie !").gold
      if @life + 50 > 100 
        @life = 100 
      else
        @life += 50
      end
    else 6
      if @life + 80 > 100 
        @life = 100 
      else
        @life += 80
      end
      puts Rainbow("Waow, tu as trouvé un pack de +80 points de vie !").gold
    end
  end
end