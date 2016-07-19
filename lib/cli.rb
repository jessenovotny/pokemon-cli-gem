# Our CLI Controller
class CLI
  def call
    welcome
    Scraper.new.make_relationships
    battle_assist
    good_bye
  end

  def welcome
    puts "Welcome to the Pokemon Battle Assistant"
    puts "Loading pokemon types..."
  end

  def battle_assist
    input = nil
    until input == "exit"
      puts ""
      puts "What type is your opponent? Please select 1-18 or type exit"
      Type.list_types
      puts ""
      input = gets.strip.to_i - 1
      @type = Type.all[input]
      good_pokemon
      good_moves
      puts "-----------------------"
      bad_pokemon
      bad_moves
      puts ""
      puts "Would you like to check another type? Y/N."
      input = gets.strip.downcase 
      input = "exit" if input == "n"
    end
  end

  def good_pokemon #uses 
    good_pokemon = []
    @type.not_very_effective.each {|pokemon| good_pokemon << pokemon}
    @type.no_effect.each {|pokemon| good_pokemon << pokemon if !good_pokemon.include?(pokemon)}
    if good_pokemon.count > 0
      puts ""
      puts "USE POKEMON OF THESE TYPE(S)"
      good_pokemon.each_with_index {|pokemon, index| puts "#{index +1}. #{pokemon.name}"}
    end
  end

  def good_moves #uses :weak against
    if @type.weak_against.count > 0
      puts ""
      puts "USE MOVES OF THESE TYPE(S)" 
      @type.weak_against.each_with_index {|move, index| puts "#{index +1}. #{move.name}"}
    end
  end

  def bad_pokemon #uses :super_affective
    if @type.super_effective.count > 0
      puts ""
      puts "AVOID POKEMON OF THESE TYPE(S)"
      @type.super_effective.each_with_index {|pokemon, index| puts "#{index +1}. #{pokemon.name}"}
    end
  end

  def bad_moves # uses :zero_effect_on and :strong_against
    bad_moves = []
    @type.not_effected_by.each {|move| bad_moves << move}
    @type.strong_against.each {|move| bad_moves << move if !bad_moves.include?(move)}
    if bad_moves.count > 0
      puts ""
      puts "AVOID MOVES OF THESE TYPE(S)"
      bad_moves.each_with_index {|move, index| puts "#{index +1}. #{move.name}"}
    end
  end


  def good_bye
    puts "Go catch 'em all!"
  end
  


    
end