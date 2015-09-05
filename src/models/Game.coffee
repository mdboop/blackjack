class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gameOutcome', null
    @get('dealerHand').hasBlackJack()

  hitCheck: ->
    debugger
    playerScore = @get('playerHand').scores()
    if playerScore[0] > 21 then @decider()

  decider: (blackjack) ->
    # debugger
    playerScore = @get('playerHand').scores()
    dealer = @get('dealerHand')
    dealerScore = dealer.scores()
    win = 'Congratuladylations!  You WON!  Savor it while it lasts ...'
    lose = 'YOU LOSE, YOU LOSING LOSER. playerCry();'
    draw = 'Meh, it\'s a draw.  Yawn.'

    if blackjack
      if playerScore[0] is 21 then @gameOver draw
      else @gameOver lose
    else if playerScore[0] > 21 then @gameOver lose
    else if (playerScore[0] > dealerScore[0]) or (dealerScore[0] > 21)
      @gameOver win
    else if (dealerScore[0] > playerScore[0])
      @gameOver lose 
    else if (dealerScore[0] is playerScore[0])
      @gameOver draw


  gameOver: (outcome) -> 
    @set 'gameOutcome', outcome
    @trigger 'gameOver'