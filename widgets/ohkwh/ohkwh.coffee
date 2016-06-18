class Dashing.Ohkwh extends Dashing.Widget
  constructor: ->
    super
    @queryState()

  @accessor 'state',
    get: -> if @_state then parseFloat(@_state).toFixed(2) else 0
    set: (key, value) -> 
      @_state = value

  queryState: ->
    $.get '/openhab/dispatch',
      widgetId: @get('id'),
      deviceId: @get('device'),
      deviceType: 'kwh'
      (data) =>
        json = JSON.parse data
        @set 'state', json.state
  ready: ->

  onData: (data) ->
