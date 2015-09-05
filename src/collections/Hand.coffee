class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if !@isDealer
      @add(@deck.pop())
      @last()
      @trigger 'hit', @
    if @isDealer
      debugger
      if @at(0).get('revealed') is false
        @at(0).flip()
      else
        #add a card
      dealerScore = @scores()[0]
      if dealerScore > 21 then @trigger 'playerWin'
      if dealerScore < 17 then @hit()
      else @stand()


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


