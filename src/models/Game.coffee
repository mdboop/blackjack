class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gameOutcome', null

  decider: ->
    playerScore = @get('playerHand').scores()
    dealer = @get('dealerHand')
    if playerScore[0] > 21 then @gameOver 'YOU LOSE, LOSER'
    if (dealer.hasBlackJack and playerScore[0] is 21)
      console.log 'it\'s a draw!'

    return

  gameOver: (outcome) -> 
    @set 'gameOutcome', outcome
    @trigger 'gameOver'