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
    @model.get('playerHand').on('hit', @model.decider, @model)
    @model.get('playerHand').on('playerStand', @model.get('dealerHand').hit, @model.get('dealerHand'))
    @model.get('dealerHand').on('blackJack', @model.decider)

    return

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.outcome-container').html new OutcomeView(model: @model).el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el