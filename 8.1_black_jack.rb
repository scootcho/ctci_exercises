# ### Problem:
# Design the data structures for a generic deck of cards. Explain how you would subclass the data structures to implement blackjack.  

# ### Clarification:
# do we just need to provide the subclass of models or should we implement the game?
# does generic deck of cards means 4 suits (club, diamond, heart, spade) with 13 cards in each suit totaling 52 cards?
# is it a 1 on 1 game with the dealer or multiplayer?

# ### Assumptions:
# 1 on 1 game with dealer
# implement the game

# ### Solution:
# inspiration: https://github.com/werdlerk/blackjack-console

class Card
  attr_accessor :suit, :value, :points

  def initialize(suit, value)
    @suit = suit
    @value = value
    @points = point_mapping(value)
  end

  def point_mapping(value)
    return value.to_i unless value.to_i == 0

    case value
      when 'A'; 11
      when 'J', 'Q', 'K'; 10
    end
  end

  def is_ace?
    @value == 'A'
  end

end


class Deck
  attr_accessor :cards

  def initialize(num_decks=1)
    @cards = []
    # For each amount_decks, create the deck using an array of suits and an array of values
    num_decks.times do
      ['hearts','diamonds','spades','clubs'].each do |suit|
        ['A','2','3','4','5','6','7','8','9','10','J','Q','K'].each do |value|
          @cards << Card.new(suit, value)
        end
      end
    end

    shuffle!
  end

  def shuffle!
    @cards.shuffle!
  end

  def take_card
    @cards.pop
  end

end


class Player
  attr_accessor :name
  attr_accessor :cards

  def initialize(name, is_dealer=false)
    @name = name
    @is_dealer = is_dealer
    @cards = []
  end

  def cards_points
    aces_count = 0
    total_points = 0

    cards.each do |card| 
      total_points += card.points
    end

    # Take into account any aces if the total value is higher then 21
    cards.select{ |card| card.is_ace? }.count.times do
      total_points -= 10 if total_points > 21
    end

    total_points
  end

  def show_cards
    @cards.each do |card|
      p "#{card.value} #{card.suit}" 
    end
  end

end


class BlackJackGame
   
  def initialize
    p "Let's play Blakjack!"
    p "what's your name?"
    name = gets.chomp
    @player = Player.new(name)
    @dealer = Player.new("Dealer", true)
    p @player
    p @dealer
    @deck = Deck.new

    deal_round
  end

  def deal_round
    p "Dealing Cards"
    @player.cards << @deck.take_card
    @dealer.cards << @deck.take_card
    @player.cards << @deck.take_card
    @dealer.cards << @deck.take_card
    show_status
    evaluate_game
  end

  def show_status
    p "===== Player ======"
    p "#{@player.name}:"
    @player.show_cards
    p "Total Points: #{@player.cards_points}"
    p "===== Dealer ======"
    p "#{@dealer.name}:"
    @dealer.show_cards
    p "Total Points: #{@dealer.name}: #{@dealer.cards_points}"
  end

  def hit
    @player.cards << @deck.take_card
  end

  def stay
    @dealer.cards << @deck.take_card if @dealer.cards_points <= 16
  end

  def evaluate_game
    if @player.cards_points < 21 && @option != "s"
      play_options
    elsif @player.cards_points > 21
      p "BUST!"  
      return
    elsif @dealer.cards_points > 21
      p "YOU WIN!"
      return
    elsif @player.cards_points == @dealer.cards_points
      p "PUSH"
      return
    elsif @player.cards_points > @dealer.cards_points
      p "YOU WIN!"
      return
    elsif @player.cards_point < @dealer.cards_points
      p "DEALER WINS!"
      return
    end
  end

  def play_options
    p "Do you want to hit (h) or stay (s) ?"
    @option = gets.chomp
    case @option
    when "h"
      hit
      show_status
      evaluate_game
    when "s"
      stay 
      show_status
      evaluate_game
    end
  end
end


### Sample Output:

BlackJackGame.new
# "Let's play Blakjack!"
# "what's your name?"
# Scott
# <Player:0x007fd7711b3488 @name="Scott", @is_dealer=false, @cards=[]>
# <Player:0x007fd7711b3410 @name="Dealer", @is_dealer=true, @cards=[]>
# "Dealing Cards"
# "===== Player ======"
# "Scott:"
# "7 diamonds"
# "A hearts"
# "Total Points: 18"
# "===== Dealer ======"
# "Dealer:"
# "2 clubs"
# "4 diamonds"
# "Total Points: Dealer: 6"
# "Do you want to hit (h) or stay (s) ?"
# s
# "===== Player ======"
# "Scott:"
# "7 diamonds"
# "A hearts"
# "Total Points: 18"
# "===== Dealer ======"
# "Dealer:"
# "2 clubs"
# "4 diamonds"
# "Q clubs"
# "Total Points: Dealer: 16"
# "YOU WIN!"


# ### Additional Resources:
# http://codereview.stackexchange.com/questions/37165/weekend-challenge-ruby-poker-hand-evaluation
# http://rubyquiz.com/quiz24.html
# http://rubyquiz.com/quiz151.html
# http://rubyquiz.com/quiz152.html
# https://github.com/pda/roflbalt
# http://rubyquiz.com/quiz80.html
# https://github.com/nodanaonlyzuul/asciiart/blob/master/bin/asciiart
# https://github.com/miketierney/artii
# http://radek.io/2015/06/29/catpix/
# https://github.com/pazdera/catpix
# https://github.com/cslarsen/jp2a
# https://github.com/tj/terminal-table
# https://github.com/yaronn/blessed-contrib
# https://github.com/yaronn/wopr
