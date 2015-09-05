class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hasBlackJack: -> 
    firstRank = @at(0).get('rank')
    secondRank = @at(1).get('rank')

    if (firstRank is 1) or (secondRank is 1)
      if (firstRank is 0 or firstRank >= 10) or (secondRank is 0 or secondRank >= 10)
        @at(0).flip()
        @trigger 'Blackjack'
        true

  hit: ->
    if !@isDealer
      @add(@deck.pop())
      @last()
      @trigger 'hit', @
    if @isDealer
      if @at(0).get('revealed') is false
        @at(0).flip()
      else
        @add(@deck.pop())
        @last()
      dealerScore = @scores()[0]
      if dealerScore > 21 then @trigger 'playerWin'
      if dealerScore < 17 then @hit()
      else @stand()
    @last()

  stand: -> 
    if !@isDealer
      @trigger 'playerStand'
    else  
      @trigger 'dealerStand'

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  scoresView: -> 
    scores = @scores()
    if (scores[0] is scores[1]) or ((scores[1] > 21) or !@at(0).get('revealed'))
      "#{scores[0]}"
    else
      "#{scores[0]} / #{scores[1]}"


