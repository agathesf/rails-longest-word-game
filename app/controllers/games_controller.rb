require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 9.times.map { ('A'..'Z').to_a.sample }.join(' ')
  end

  def score
    @result = params[:result]
    @letters = params[:letters]

    if include_letters?(@result) && english_word?
      @message = 'Congratulation'
    elsif include_letters?(@result)
      @message = 'Not an english word'
    else
      @message = 'Not in the grid'
    end
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@result}"
    word = open(url).read
    words = JSON.parse(word)
    words["found"]
  end

  def include_letters?(input)
    raise
    input.upcase.split('').all? { |letter| @letters.include?(letter) }
    # CREATE AN HASH FROM INPUT (ARRAY) key = letter, value = number of letter
    # ruby array, compare count of letters
    @letters.count
  end

end
