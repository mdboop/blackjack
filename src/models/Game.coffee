class window.Game extends Backbone.Model

  defaults :

    'blackJack': false
    'deck': deck = new Deck()
    'roundOver': false
    'gameOutcome': null

  initialize: ->
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  hitCheck: ->
    lose = 'ダメだったな〜〜'
    playerScore = @get('playerHand').maxScore()
    if playerScore > 21 then @roundOver lose

  decider: ->
    playerScore = @get('playerHand').maxScore()
    dealer = @get('dealerHand')
    dealerScore = dealer.maxScore()
    win = '신기하다! 진짜잘했죠, 근데 한번도 해보면 운이 안좋으겠어 ...'
    lose = 'ダメだったな〜〜！（＾v＾）'
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
    @set 'roundOver', true
    @trigger 'roundOver'

  newRound: ->
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'roundOver', false
    @set 'gameOutcome', null
    @set 'blackJack', false
    @trigger 'newRound'