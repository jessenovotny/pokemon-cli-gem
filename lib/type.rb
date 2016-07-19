class Type
  attr_reader :name, :url
  attr_accessor :super_effective, :not_very_effective, :no_effect, :not_effected_by, :strong_against, :weak_against

  @@all = []

  def initialize name, url
    @name = name    
    @url = url
    @super_effective = []
    @not_very_effective = []
    @no_effect = [] #this type's moves have no effect on these
    @not_effected_by = [] #these type moves have zero effect on this type
    @strong_against = []
    @weak_against = []
    @@all << self
  end

  def self.find_by_name name
    self.all.detect{|type| type.name == name}
  end

  def self.list_types
    @@all.each_with_index do |type, index|
      puts "#{index + 1}. #{type.name}"
    end
  end


  def self.all
    @@all
  end

end