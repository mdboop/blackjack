class window.GameView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="outcome-container"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()

  initialize: ->
    @render()
    @model.get('playerHand').on('hit', @model.hitCheck, @model)
    @model.get('playerHand').on('playerStand', @model.get('dealerHand').hit, @model.get('dealerHand'))
    @model.get('dealerHand').on('Blackjack', @model.blackJack, @model)
    @model.get('dealerHand').on('dealerStand', @model.decider, @model)
    @model.get('dealerHand').hasBlackJack()
    @model.on('roundOver', @disableButtons)
    @model.on('newRound', @setNewRound, @)

    return

  disableButtons: ->
    $('.hit-button').attr "disabled", 'disabled'
    $('.stand-button').attr "disabled", 'disabled'

  setNewRound: ->
    @$el.children().detach() 
    $('.hit-button').removeAttr "disabled"
    $('.stand-button').removeAttr "disabled"
    @model.get('playerHand').on('hit', @model.hitCheck, @model)
    @model.get('playerHand').on('playerStand', @model.get('dealerHand').hit, @model.get('dealerHand'))
    @model.get('dealerHand').on('Blackjack', @model.blackJack, @model)
    @model.get('dealerHand').on('dealerStand', @model.decider, @model)
    @model.get('dealerHand').hasBlackJack()
    @model.on('roundOver', @disableButtons)
    @model.on('newRound', @setNewRound, @)
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.outcome-container').html new OutcomeView(model: @model).el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el