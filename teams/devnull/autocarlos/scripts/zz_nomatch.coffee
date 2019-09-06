
module.exports = (robot) ->

  robot.respond /(\S*)(.*)/i, (res) ->
    if((res.match[1] || '').toLowerCase() != 'graf')
      res.send "Sorry, I could not understand that. Forwarding your question to my master <@UN27Z5Y86>"
      res.finish()
