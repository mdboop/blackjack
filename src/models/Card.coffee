class window.Card extends Backbone.Model
  initialize: (params) ->
    @set
      revealed: true
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      suitName: ['spades', 'diamonds', 'clubs', 'hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'king'
        when 1 then 'ace'
        when 11 then 'jack'
        when 12 then 'queen'
        else params.rank
    @setImages()

  setImages: ->
    rankName = @get 'rankName'
    suitName = @get 'suitName'
    @set 'currentImage', "img/cards/#{rankName}-#{suitName}.png"
    @set 'altImage', "img/card-back.png"
  flip: ->
    debugger
    @set 'revealed', !@get 'revealed'
    tempImage = @get 'currentImage'
    @set 'currentImage', @get 'altImage'
    @set 'altImage', tempImage
    @

