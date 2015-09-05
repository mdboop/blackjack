class window.OutcomeView extends Backbone.View

  className: 'outcome'
  
  template: _.template('<div><%= gameOutcome %></div>
                        <button class=roundOver>next round</button>
                        ')
  events: 
    'click button': 'newRound'

  initialize : ->
    @model.on('roundOver', @render, @)

  newRound: (e) ->
    @model.newRound()
    @$el.empty()

  render: ->
    @$el.html @template @model.attributes
    