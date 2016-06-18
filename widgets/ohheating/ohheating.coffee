class Dashing.Ohheating extends Dashing.Widget
  constructor: ->
    super
    @queryState()

  @accessor 'state',
    get: -> @_state ? "Unknown"
    set: (key, value) -> 
      @_state = value
      

  @accessor 'mode',
    get: -> @_mode ? 'Off'
    set: (key, value) -> 
      @_mode = value

  @accessor 'temperature',
    get: -> if @_temperature then parseFloat(@_temperature).toFixed(1) else 0
    set: (key, value) -> 
      @_temperature = value

  @accessor 'target',
    get: -> if @_target then parseFloat(@_target).toFixed(1) else 0
    set: (key, value) -> 
      @_target = value

  @accessor 'hvacstate',
    get: -> @_hvacstate ? 'Off'
    set: (key, value) -> 
      @_hvacstate = value

  @accessor 'hvacmode-style', ->
    if @get('mode') == "Heating"
      console.log "style: current-heat"
      'current-heat'       
    else if @get('mode') == "Cooling" 
      console.log "style: current-cool"
      'current-cool' 
    else
      console.log "style: current-off"
      'current-off'

  @accessor 'hvacstate-style', ->
    if @get('hvacstate') == "Heating"
      console.log "style: opheat"
      'heating-opheat'       
    else if @get('hvacstate') == "Cooling" 
      console.log "style: opcool"
      'heating-opcool' 
    else
      console.log "style: opoff"
      'heating-opoff'
      
  queryState: ->
    $.get '/openhab/dispatch',
      widgetId: @get('id'),
      deviceId: @get('device'),
      deviceType: 'temperature'
      (data) =>
        json = JSON.parse data
        @set 'state', json.state

        jsonInner = JSON.parse json.state
        @set 'mode', jsonInner.mode
        @set 'temperature', jsonInner.temperature
        @set 'target', jsonInner.target
        @set 'hvacstate', jsonInner.hvacstate
        console.log 'mode: ', jsonInner.mode, 'temperature: ', jsonInner.temperature, ' target: ', jsonInner.target, 'hvacstate: ', jsonInner.hvacstate
        console.log json, ' Inner: ', jsonInner

  ready: ->

  onData: (data) ->
    debugger
    console.log "data",data
    json = JSON.parse data
    @set 'state', json.state
    jsonInner = JSON.parse json.state
    @set 'mode', jsonInner.mode
    @set 'target', jsonInner.target
    @set 'temperature', jsonInner.temperature
    @set 'hvacstate', jsonInner.hvacstate
    console.log "mode: ", @get('mode'), "temperature: ", @get('temperature'), " target: ", @get('target'), " hvacstate: ", @get('hvacstate')
