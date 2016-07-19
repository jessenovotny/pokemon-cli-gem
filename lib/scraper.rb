class Scraper
  def get_page
    page = Nokogiri::HTML(open("http://pokemondb.net/type"))
  end

  def make_types
    # takes scraped info and creates a new class for each type
    
    self.get_page.css(".type-icon-list a").each do |type|
      Type.new(type.text, "http://pokemondb.net#{type["href"]}")
    end
  end

  def make_relationships
    self.make_types
    # iterate over @@all Types and scrape each one's URL to create relationships
    Type.all.each do |type|
      page = Nokogiri::HTML(open("#{type.url}")).css(".colset .col")[0]
      page.css("p").each_with_index do |rel, index|
        binding.pry
        if rel.text.include?("moves are super-effective")
          binding.pry
          page.css('div')[index].text.strip.split.each {|other_type| type.super_effective << Type.find_by_name(other_type) }
          binding.pry
        elsif rel.text.include?("moves are not very effective")
          page.css('div')[index].text.strip.split.each {|other_type| type.not_very_effective << Type.find_by_name(other_type) }
          
        end
      end

    end
  end
end
