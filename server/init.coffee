Meteor.startup ->
	Inject.rawModHtml "addUnresolved", (html) ->
		html = html.replace("<body>","<body unresolved fullbleed layout vertical>")