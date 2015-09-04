class window.AppView extends Backbone.View

  tagName: "div"

  initialize: ->
    @render()
    new GameView(model: new Game()).$el.appendTo @$el

  render: ->
    @$el

