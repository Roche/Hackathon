

module.exports = (robot) ->
  robot.respond /make me a sandwich$/i, (msg) ->
    msg.reply "What! Make it yourself"
    msg.finish()

  
  robot.respond /sudo make me a sandwich$/i, (msg) ->
    msg.send "OK, here it is"
    msg.send {"text":"https://imgs.xkcd.com/comics/sandwich.png", "unfurl_links": true}
    msg.finish()
