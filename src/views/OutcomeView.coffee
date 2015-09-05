class window.OutcomeView extends Backbone.View

  className: 'outcome'
  
  template: _.template('<div><%= gameOutcome %></div>
                        <button class=roundOver>next round</button>
                        ')

  initialize : ->
    @model.on('roundOver', @render, @)
    

  render: ->
    @$el.html @template @model.attributes
    