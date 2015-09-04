class window.OutcomeView extends Backbone.View

  className: 'outcome'
  
  template: _.template('<div><%= gameOutcome %></div>')

  initialize : ->
    @model.on('gameOver', @render, @)

  render: ->
    debugger
    @$el.html @template @model.attributes
    