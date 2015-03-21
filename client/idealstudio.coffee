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
		if page in ['preco-idealstudio','nasa-praca','vzorovy-projekt']
			console.log 'som dnu'
			$('#'+page).slick
				dots: true
				arrows: true
				cssEase: 'linear'
			return

Template.app.events
  'click paper-item': (e,t) ->
  	t.find('#pages').selected = e.target.attributes.label.value