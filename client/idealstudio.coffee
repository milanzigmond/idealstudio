showMap = () ->
	return if Session.get 'mapInitialized'
	center = new (google.maps.LatLng)(48.323383, 18.097106)
	options =
    center: center
    scrollwheel: false
    zoom: 14
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new (google.maps.Map)(document.getElementById('map'), options)
	marker = new (google.maps.Marker)(position: center)
	marker.setMap map
	Session.set 'mapInitialized', true

showToast = (toast) ->
	Session.set('toast', toast)
	document.getElementById('toast').show()

initializeOwlCarousel = (page) ->
	console.log 'initializeOwlCarousel with page:'+page
	owl = $('.'+page).owlCarousel
    loop:true
    items:1
    center: if page == 'preco-idealstudio' then true else false
    lazyLoad:true
    transitionStyle : "fade"
    responsive:
    	900:
      	items: if page == 'preco-idealstudio' then 2 else 1
  console.log owl

  data = owl.data('owlCarousel')

  $('.'+page+'-nav .previous').click ->
  	data.prev()
	$('.'+page+'-nav .next').click ->
		data.next()

Template.app.rendered = () ->
	initializeOwlCarousel('preco-idealstudio')
	initializeOwlCarousel('nasa-praca')
	initializeOwlCarousel('vzorovy-projekt')

	# initialize tabs
	tabs = document.querySelector('#tabs')
	steps = document.querySelector('#steps')
	tabs.addEventListener 'core-select', ->
		steps.selected = tabs.selected

	pages = document.querySelector('#pages')
	pages.addEventListener 'core-animated-pages-transition-end', (e) ->
		page = e.target.selectedItem.attributes.label.value
		if page == 'kontakt'
			showMap()
			$('#send').on 'click', (e) ->
				if e?
					to = '<milanzigmond@gmail class="com"></milanzigmond@gmail>'
					from = $('#email').val()
					subject = $('#subject').val()
					message = $('#message').val()
					Meteor.call 'sendEmail', to, from, subject, message, (err) ->
						if !err
							showToast('Správa úspešne odoslaná')
							$('#email').val('')
							$('#subject').val('')
							$('#message').val('')
						else
							showToast(err.reason)
							console.log err.reason
	$('.menuItem').on 'click', (e) ->
    if e?
	    page = e.target.attributes.label.value
	  	pages = document.getElementById('pages')
	  	pages.selected = page
	  	return
	  return

Template.app.helpers
	toast: () ->
		Session.get 'toast'

Template.app.events
	'click .owl-previous': () ->
		console.log 'owl-previous'
		$('.owl-carousel').trigger('owl.prev')
	'click .owl-next': () ->
		console.log 'owl-next'
		$('.owl-carousel').trigger('owl.next')
