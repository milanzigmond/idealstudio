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

Template.app.rendered = () ->
	$('#preco-idealstudio').slick
		dots: true
		arrows: true
		cssEase: 'linear'

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
					to = 'millanzigmond@gmail.com'
					from = $('#email').val()
					subject = $('#subject').val()
					message = $('#message').val()
					Meteor.call 'sendEmail', to, from, subject, message, (err) ->
						if !err
							showToast('Správa úspešne poslaná')
							$('#email').val('')
							$('#subject').val('')
							$('#message').val('')
						else
							showToast(err.reason)
							console.log err.reason
		if page in ['preco-idealstudio','nasa-praca','vzorovy-projekt','kontakt']
			$('#'+page).slick
				dots: true
				arrows: true
				cssEase: 'linear'
			return

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