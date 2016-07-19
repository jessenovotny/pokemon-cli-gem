# Our CLI Controller
class CLI
  def call
    welcome
    Scraper.new.make_relationships
    input = nil
    # until input == "exit"
      puts "What type is your opponent?"
      Type.list_types
      input = gets.strip.downcase

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