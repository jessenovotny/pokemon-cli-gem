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
      puts "What would you like to do?"
      puts "1. Check an opponent's type"
      puts "2. Check your Defense's type"
      puts "3. Check your Attack's type"
      puts "4. Exit"
      puts ""
      input = gets.strip
      if input == "1"
        puts ""
        opponent_type
      elsif input == "2"
        puts ""
        # pokemon_type
      elsif input == "3"
        puts ""
        attack_type
      elsif input.downcase == "exit" || input == "4"
        input = "exit"
      else
        puts "Invalid option. Let's try again..."
      end      
    end
  end

  def opponent_type
    input = nil
    until input == "exit"
      puts "What type is your opponent? Please select 1-18 or type exit"
      Type.list_types
      puts ""
      input = gets.strip
      until input == "exit" || input.to_i.between?(1,18)
        puts "Innvalid entry. Please select a type or exit"
        puts ""
        input = gets.strip
      end
      if input != "exit"
        @type = Type.all[input.to_i - 1]
        good_pokemon
        good_moves
        puts "-----------------------"
        bad_pokemon
        bad_moves
        puts ""
        puts "Would you like to check another type? Y/N."
        puts ""
        input = gets.strip.downcase 
        puts ""
        input = "exit" if input == "n"
      end
    end # until
  end

  def defense_type
    input = nil
    until input == "exit"
      puts "What type is your Pokemon? Please select 1-18 or type exit"
      Type.list_types
      puts ""
      input = gets.strip
      until input == "exit" || input.to_i.between?(1,18)
        puts "Innvalid entry. Please select a type or exit"
        puts ""
        input = gets.strip
      end
      if input != "exit"
        @type = Type.all[input.to_i - 1]
        use_against
        puts ""
        puts "-----------------------"
        dont_use_against
        puts ""
        puts "Would you like to check another type? Y/N."
        puts ""
        input = gets.strip.downcase 
        puts ""
        input = "exit" if input == "n"
      end
    end # until
  end

  def attack_type
    input = nil
    until input == "exit"
      puts "What type is your Attack? Please select 1-18 or type exit"
      Type.list_types
      puts ""
      input = gets.strip
      until input == "exit" || input.to_i.between?(1,18)
        puts "Innvalid entry. Please select a type or exit"
        puts ""
        input = gets.strip
      end
      if input != "exit"
        @type = Type.all[input.to_i - 1]
        use_attack
        puts ""
        puts "-----------------------"
        dont_use_attack
        puts ""
        puts "Would you like to check another type? Y/N."
        puts ""
        input = gets.strip.downcase 
        puts ""
        input = "exit" if input == "n"
      end
    end # until
  end




  def use_attack
    use = []
    @type.super_effective.each {|type| use << type if !use.include?(type)}
    @type.not_effected_by.each {|type| use << type if !use.include?(type)}
    @type.strong_against.each {|type| use << type if !use.include?(type)}
    puts ""
    puts "USE #{@type.name.upcase} AGAINST :"
    use.each_with_index {|other_type, index| puts "#{index+1}. #{other_type.name}"}
  end

  def dont_use_attack
    dont_use = []
    @type.not_very_effective.each {|type| dont_use << type if !dont_use.include?(type)}
    @type.no_effect.each {|type| dont_use << type if !dont_use.include?(type)}
    @type.weak_against.each {|type| dont_use << type if !dont_use.include?(type)}
    puts ""
    puts "DO NOT USE #{@type.name.upcase} AGAINST:"
    dont_use.each_with_index {|other_type, index| puts "#{index+1}. #{other_type.name}"}
  end

  def good_pokemon #uses :not_very_effective AND :no_effect
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

  def bad_pokemon #uses :super_effective
    if @type.super_effective.count > 0
      puts ""
      puts "AVOID POKEMON OF THESE TYPE(S)"
      @type.super_effective.each_with_index {|pokemon, index| puts "#{index +1}. #{pokemon.name}"}
    end
  end

  def bad_moves # uses :zero_effect_on AND :strong_against
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
    puts ""
    puts "Go catch 'em all!"
  end
  
end