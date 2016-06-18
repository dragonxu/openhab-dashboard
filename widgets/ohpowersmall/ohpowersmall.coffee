class Dashing.Ohpowersmall extends Dashing.ClickableWidget
  constructor: ->
    super
    @queryState()

  @accessor 'state',
    get: -> if @_state then parseFloat(@_state).toFixed(0) else 0
    set: (key, value) -> 
      @_state = value

  @accessor 'powersmallstate-style', ->
    if @get('state') < 1000
      console.log "style: powersmall-low"
      'powersmall-low'       
    else if @get('state') >= 3000
      console.log "style: powersmall-high"
      'powersmall-high' 
    else
      console.log "style: powersmall-med"
      'powersmall-med'

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

  onClick: (node, event) ->
    Dashing.cycleDashboardsNow(
      boardnumber: @get('page'),
      stagger: @get('stagger'),
      fastTransition: @get('fasttransition'),
      transitiontype: @get('transitiontype'))