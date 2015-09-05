class window.Game extends Backbone.Model

  defaults :

    'blackJack': false
    'deck': deck = new Deck()

  initialize: ->
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gameOutcome', null

  hitCheck: ->
    lose = 'YOU LOSE, YOU LOSING LOSER. playerCry();'
    playerScore = @get('playerHand').maxScore()
    if playerScore > 21 then @roundOver lose

  decider: ->
    playerScore = @get('playerHand').maxScore()
    dealer = @get('dealerHand')
    dealerScore = dealer.maxScore()
    win = 'Congratuladylations!  You WON!  Savor it while it lasts ...'
    lose = 'YOU LOSE, YOU LOSING LOSER. playerCry();'
    draw = 'Meh, it\'s a draw.  Yawn.'
    if @get('blackJack')
      if playerScore[0] is 21 then @roundOver draw
      else @roundOver lose

    else if playerScore > dealerScore then @roundOver win
    else if dealerScore > 21 then @roundOver win
    else if playerScore is dealerScore then @roundOver draw 
    else @roundOver lose 

  blackJack: ->
    @set 'blackJack', true
    @decider()

  roundOver: (outcome) -> 
    @set 'gameOutcome', outcome
    @trigger 'roundOver'