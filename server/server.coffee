Meteor.startup ->
  # process.env.MAIL_URL = 'smtp://localhost:25'
	Inject.rawModHtml "addUnresolved", (html) ->
    html = html.replace("<body>","<body unresolved fullbleed layout vertical>")
  

Meteor.methods {
  sendEmail: (to, from, subject, text) ->
    console.log 'sendEmail called : '+to+from+subject+text
    check [
      to
      from
      subject
      text
    ], [ String ]
    # Let other method calls from the same client start running,
    # without waiting for the email sending to complete.
    @unblock()
    Email.send ({
      to: to
      from: from
      subject: subject
      text: text
    })
  }