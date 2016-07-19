# Our CLI Controller
class CLI
  def call
    welcome
    Scraper.new.make_relationships
    input = nil
    until input == "exit"
      puts "What type is your opponent? Please select 1-18 or type exit"
      Type.list_types
      input = gets.strip.to_i - 1
      type = Type.all[input]
      
      
      good_pokemon = []
      type.not_very_effective.each {|pokemon| good_pokemon << pokemon}
      type.no_effect.each {|pokemon| good_pokemon << pokemon if !good_pokemon.include?(pokemon)}
      puts "USE POKEMON OF THESE TYPE(S)"
      good_pokemon.each_with_index {|pokemon, index| puts "#{index +1}. #{pokemon.name}"}

      puts "USE MOVES OF THESE TYPE(S)"
      type.weak_against.each_with_index {|move, index| puts "#{index +1}. #{move.name}"}

      puts "AVOID POKEMON OF THESE TYPE(S)"
      type.super_effective.each_with_index {|pokemon, index| puts "#{index +1}. #{pokemon.name}"}

      puts "AVOID MOVES OF THESE TYPE(S)"
      bad_moves = []
      type.zero_effect_on.each {|move| bad_moves << move}
      type.no_effect.each {|move| bad_moves << move if !bad_moves.include?(move)}
      bad_moves.each_with_index {|move, index| puts "#{index +1}. #{move.name}"}



      puts "#{type.name} type Pokemon are weakest against moves of the following type(s):"
      #type.weak_against.each_with_index {|other_type, index| puts "#{index + 1}. #{other_type.name}"}
      puts ""
      puts "#{type.name} type moves have no effect on Pokemon of the following type(s)"
      type.weak_against.each_with_index {|other_type, index| puts "#{index + 1}. #{other_type.name}"}
      puts ""
      puts "You should also avoid using the following type(s) of pokemon, which #{type.name} type moves are strongest against:"
      type.strongest_agaisnt.each_with_index {|other_type, index| puts "#{index + 1}. #{other_type.name}"}


    end


    # ask what they want to do.
    # What type is your opponent?
    # What is your Pokemon's type?
    # USER INPUT

  end

  def welcome
    puts "Welcome to the Pokemon Battle Assistant"
    puts "Do you have what it takes to be a Pokemon Master?"
  end
  


    
end