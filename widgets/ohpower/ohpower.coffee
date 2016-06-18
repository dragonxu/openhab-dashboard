class Dashing.Ohpower extends Dashing.Widget
  constructor: ->
    super
    @queryState()

  @accessor 'state',
    get: -> if @_state then parseFloat(@_state).toFixed(0) else 0
    set: (key, value) -> 
      @_state = value

  @accessor 'powerstate-style', ->
    if @get('state') < 1000
      console.log "style: power-low"
      'power-low'       
    else if @get('state') >= 3000
      console.log "style: power-high"
      'power-high' 
    else
      console.log "style: power-med"
      'power-med'

  queryState: ->
    $.get '/openhab/dispatch',
      widgetId: @get('id'),
      deviceId: @get('device'),
      deviceType: 'cost'
      (data) =>
        json = JSON.parse data
        @set 'state', json.state
  ready: ->

  onData: (data) ->