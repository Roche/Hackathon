

module.exports = (robot) ->
  robot.respond /Which.*text editor (should|could|can) i use/i, (msg) ->
    msg.reply "There's only one editor: VIM"
    msg.send {"text":"https://imgs.xkcd.com/comics/real_programmers.png", "unfurl_links": true}
    msg.finish()

