class window.Game extends Backbone.Model

  defaults :

    'blackJack': false

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gameOutcome', null

  hitCheck: ->
    lose = 'YOU LOSE, YOU LOSING LOSER. playerCry();'
    playerScore = @get('playerHand').maxScore()
    if playerScore > 21 then @gameOver lose

  decider: ->
    playerScore = @get('playerHand').maxScore()
    dealer = @get('dealerHand')
    dealerScore = dealer.maxScore()
    win = 'Congratuladylations!  You WON!  Savor it while it lasts ...'
    lose = 'YOU LOSE, YOU LOSING LOSER. playerCry();'
    draw = 'Meh, it\'s a draw.  Yawn.'
    if @get('blackJack')
      if playerScore[0] is 21 then @gameOver draw
      else @gameOver lose

    else if playerScore > dealerScore then @gameOver win
    else if dealerScore > 21 then @gameOver win
    else if playerScore is dealerScore then @gameOver draw 
    else @gameOver lose 

  blackJack: ->
    @set 'blackJack', true
    @decider()

  gameOver: (outcome) -> 
    @set 'gameOutcome', outcome
    @trigger 'gameOver'