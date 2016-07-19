class Scraper
  def get_page
    binding.pry
    page = Nokogiri::HTML(open("http://pokemondb.net/type"))
  end

  def make_types
    # takes scraped info and creates a new class for each type
    
    self.get_page.css(".type-icon-list a").each do |type|
      Type.new(type.text, "http://pokemondb.net#{type["href"]}")
    end
  end

  def make_relationships all_types
    # iterate over @@all Types and scrape each one's URL to create relationships
    Types.all.each do |type|
      page = Nokogiri::HTML(open("#{type.url}")).css(".colset .col")[0]
      page.css("p").each.with_index(0) do |rel|
        if rel.text.include?("moves are super-effective")
          type.super_effective = Type.find_by_name(rel.text.strip.split[0])
        end
      end

    end
  end
end
