# Our CLI Controller
class CLI
  def call
    welcome
    Scraper.new.make_relationships
  end

  def welcome
    puts "Welcome to the Pokemon Battle Assistant"
    puts "Do you have what it takes to be a Pokemon Master?"
  end
    
end