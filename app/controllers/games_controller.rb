require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # TODO: generate random grid of letters
    # range = [*'A'..'Z']
    # range.sample(grid_size)
    @letters = Array.new(8) { ('A'..'Z').to_a.sample }
  end

  def score
    @result = {}
    @attempt = params[:word]
    @word_array = @attempt.split
    @grid = params[:grid]
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    # @result[:time] = end_time - start_time

    if user["found"]
      if @word_array.all? {|letter| @attempt.count(letter) <= @grid.count(letter)}
        @result[:message] = "Well Done"
        @result[:score] =  @attempt.length # + (1000 - @result[:time])
      else
        @result[:score] = 0
        @result[:message] = "The word is not in the #{@grid}"
      end
    else
      @result[:score] = 0
      @result[:message] = "This is not an english word"
    end

      @result
  end

end
