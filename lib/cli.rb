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
    puts "Loading Type Database..."
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
        defense_type
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
        puts ""
        puts "------------------------------"
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
        defense_use
        puts ""
        puts "------------------------------"
        defense_dont_use
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
        attack_use
        puts ""
        puts "------------------------------"
        attack_dont_use
        puts ""
        puts "Would you like to check another type? Y/N."
        puts ""
        input = gets.strip.downcase 
        puts ""
        input = "exit" if input == "n"
      end
    end # until
  end

  ### The following are helper methods for #defense_type ###
  def defense_use
    use = []
    @type.not_effected_by.each {|type| use << type if !use.include?(type)}
    @type.strong_against.each {|type| use << type if !use.include?(type)}
    puts ""
    puts "#{@type.name.upcase} POKEMON ARE RESISTANT TO:"
    use.each_with_index {|other_type, index| puts "#{index+1}. #{other_type.name}"}
  end

  def defense_dont_use
    puts ""
    puts "#{@type.name.upcase} POKEMON ARE WEAK AGAINST:" 
    @type.weak_against.each_with_index {|move, index| puts "#{index +1}. #{move.name}"}
  end

  ### The following are helper methods for #attack_type ###
  def attack_use
    puts ""
    puts "#{@type.name.upcase} MOVES ARE POWERFUL AGAINST:"
    @type.super_effective.each_with_index {|other_type, index| puts "#{index+1}. #{other_type.name}"}
  end

  def attack_dont_use
    dont_use = []
    @type.not_very_effective.each {|type| dont_use << type if !dont_use.include?(type)}
    @type.no_effect.each {|type| dont_use << type if !dont_use.include?(type)}
    puts ""
    puts "#{@type.name.upcase} MOVES ARE NOT EFFECTIVE AGAINST:"
    dont_use.each_with_index {|other_type, index| puts "#{index+1}. #{other_type.name}"}
  end

  ### The following are helper methods for #opponent_type ###
  def good_pokemon # :not_very_effective AND :no_effect
    good_pokemon = []
    @type.not_very_effective.each {|pokemon| good_pokemon << pokemon}
    @type.no_effect.each {|pokemon| good_pokemon << pokemon if !good_pokemon.include?(pokemon)}
    if good_pokemon.count > 0
      puts ""
      puts "USE POKEMON OF THESE TYPE(S)"
      good_pokemon.each_with_index {|pokemon, index| puts "#{index +1}. #{pokemon.name}"}
    end
  end

  def good_moves # :weak against
    if @type.weak_against.count > 0
      puts ""
      puts "USE MOVES OF THESE TYPE(S)" 
      @type.weak_against.each_with_index {|move, index| puts "#{index +1}. #{move.name}"}
    end
  end

  def bad_pokemon # :super_effective
    if @type.super_effective.count > 0
      puts ""
      puts "AVOID POKEMON OF THESE TYPE(S)"
      @type.super_effective.each_with_index {|pokemon, index| puts "#{index +1}. #{pokemon.name}"}
    end
  end

  def bad_moves #  :not_effected_by AND :strong_against
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