class window.OutcomeView extends Backbone.View

  className: 'outcome'
  
  template: _.template('<div><%= gameOutcome %></div>')

  initialize : ->
    @model.on('roundOver', @render, @)

  render: ->
    @$el.html @template @model.attributes
    