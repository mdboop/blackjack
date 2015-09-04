class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gameOutcome', null

  checkScore: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    if playerScore[0] > 21 then @gameOver 'YOU LOSE, LOSER'
    # else 
    return

  gameOver: (outcome) -> 
    @set 'gameOutcome', outcome
    @trigger 'gameOver'