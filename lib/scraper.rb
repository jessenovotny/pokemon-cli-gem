class Scraper
  def get_page
    page = Nokogiri::HTML(open("http://pokemondb.net/type"))
  end

  def make_types
    # takes scraped info and creates a new class for each type
    binding.pry
    self.get_page.css(".type-icon-list a").each do |type|
      Type.new(type.text, "http://pokemondb.net#{type["href"]}")
    end
  end

  def make_relationships type
    # scrape type.url and create associations
  end
end
