class GamesController < ApplicationController
  require 'json'
  require 'open-uri'
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @word.split("")
    @included = @word.chars.all? { |letter| @word.count(letter) <= 10.count(letter) }

    def score_and_message
      if @included?
      if @word == english_word?
        @response = [0, "well done"]
      elsif
        @response = [0, "not an english word"]
      else
        @response = [0, "not in the grid"]
      end
    end

    def english_word?(word)
      response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
      json = JSON.parse(response.read)
      return json['found']
    end
  end
end

require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
