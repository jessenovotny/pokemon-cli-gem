# Pokemon

Welcome to the Pokemon Battle Assistant! It's a complex world out there with lots of different exciting pokemon. When it comes to gym battles, becoming a Pokemon Master doesn't have to mean memorizing all 18 types with all of their defenses or weaknesses. Don't worry about wrapping your head around a complex matrix of attack and defense types. 

Simply initaite this Pokemon Battle Assistant, enter your opponent Pokemon's type and find out immediately, which Pokemon to use for the best defense and which moves they should have for the best offense!


## Installation

Add this line to your application's Gemfile:

```
ruby gem 'pokemon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pokemon

## Usage

Thanks for using the Pokemon Battle Assistant. Upon initialization, you will be greeted and presented a simple question, "What would you like to do?"

OPTION 1: "Check an opponent's type" is your best bet when preparing for a grueling match. 
  Enter their type and find out: 
   - which Pokemon have the best defense (USE these Pokemon)
   - which moves will provide the best offense (USE these attacks)
   - which Pokemon are weak against your opponent (DO NOT use these Pokemon)
   - which attacks will be useless against your opponent (DO NOT use these attacks)

OPTION 2: "Check your Defense" is used to see what types of moves your Pokemon is strong or weak against. 
  Enter your Pokemon's type and find out:
   - which types of moves have little or no effect on you (fight these types of Pokemon)
   - which types of moves will deal the most damage to you (DO NOT fight these types of Pokemon)

OPTION 3: "Check your Attack's type" is helpful for idenfitying which types of Pokemon are strong or weak against your offense. 
  Enter the type of your Pokemon's attack and find out:
   - which types of Pokemon are most vulnerable to your Pokemon's attack (fight these types of Pokemon)
   - which types of Pokemon are most immune to your Pokemon's attack (DO NOT fight these types of Pokemon)

It's that simple! 

A true Pokemon Master will want to utilize this tool to it's full potential before any battle to take the upper hand and never be caught off guard. 


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jessenovotny/pokemon.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

