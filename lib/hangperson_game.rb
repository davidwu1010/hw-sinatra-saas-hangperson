class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  # def initialize()
  # end
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter.nil? || letter.empty? || letter !~ /^[[:alpha:]]$/
      raise ArgumentError
    elsif @guesses.include?(letter.downcase) || @wrong_guesses.include?(letter.downcase)
      false
    else
      if word.include? letter
        @guesses << letter
      else
        @wrong_guesses << letter
      end
      true
    end
  end

  def check_win_or_lose
    if @guesses.length == @word.length
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

  def word_with_guesses
    result = ''
    @word.chars do |letter|
      result << ((@guesses.include? letter) ? letter : '-')
    end
    result
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
