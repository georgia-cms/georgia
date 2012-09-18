class Georgia.Views.ImagesPanel extends Backbone.View
  template: JST['panels/images']

  events:
    'click .controls #previous': 'previous'
    'click .controls #next': 'next'
    'click #featured_image a': 'lightbox'

  initialize: ->
    @image = @model.get('image')
    @image ?= new Georgia.Models.Image
    @position = 0
    @width = 31.623931624
    @gap = 2.564102564
    @positions = [
      {left: "#{(@width*2)+@gap}%", top: '0'}
      {left: "#{(@width*2)+@gap}%", top: "#{@width}%"}
      {left: "#{(@width*2)+@gap}%", top: "#{@width*2}%"}
      {left: "#{@width}%", top: "#{@width*2}%"}
      {left: "-#{@gap}%", top: "#{@width*2}%"}
    ]
    @collection.on('add', @appendImage, this)

  render: ->
    $(@el).html(@template(image: @image))
    @collection.each(@appendImage)
    @collection.each(@positionImage)
    this

  appendImage: (image) =>
    view = new Georgia.Views.Image(model: image, content: @model)
    @$('.thumbnails').append(view.render().el)

  previous: (event) ->
    event.preventDefault()
    unless @position <= 0
      @$('.span4').slice(@position-1,   @position+2).animate({top:  "+=#{@width+@gap}%"}, 300)
      @$('.span4').slice(@position+2,   @position+5).animate({left: "-=#{@width+@gap}%"}, 300)
      @position-=1
      @setArrows()

  next: (event) ->
    event.preventDefault()
    unless @position >= (@collection.length-5)
      @$('.span4').slice(@position,   @position+3).animate({top:  "-=#{@width+@gap}%"}, 300)
      @$('.span4').slice(@position+3, @position+6).animate({left: "+=#{@width+@gap}%"}, 300)
      @position+=1
      @setArrows()

  lightbox: (event) ->
    event.preventDefault()
    $(event.currentTarget).lightBox()

  setArrows: ->
    @previous = @$('.controls #previous')
    @next = @$('.controls #next')
    if @position <= 0 then @previous.addClass('disabled') else @previous.removeClass('disabled')
    if @position >= (@collection.length-5) then @next.addClass('disabled') else @next.removeClass('disabled')

  positionImage: (image, index) =>
    if index <= 4
      position = @getPosition(index)
      $(@$('.thumbnails li')[index+1]).animate({left: position['left'], top: position['top']})

  getPosition: (index) =>
    @positions[index]