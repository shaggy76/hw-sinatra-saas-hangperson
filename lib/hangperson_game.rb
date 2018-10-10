class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_reader :guesses
  attr_reader :word
  attr_reader :wrong_guesses

  def guess(letter)
    if letter == ''
      "Invalid guess."
    elsif /[^a-zA-Z]+/.match? letter
      "Invalid guess."
    elsif letter.nil?
      "Invalid guess."
    elsif @guesses.include? letter.downcase
      "You have already used that letter."
    elsif @word.include? letter.downcase
      @guesses << letter.downcase
    elsif @wrong_guesses.include? letter.downcase
      "You have already used that letter."
    else
      @wrong_guesses << letter.downcase
      "Invalid guess."
    end
  end

  def word_with_guesses
    output = ''
    @word.each_char do |l|
      if @guesses.include? l
        output << l
      else
       output << '-'
      end
    end
    output
  end

  def check_win_or_lose
    if @word == word_with_guesses
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
