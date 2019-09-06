module.exports = (robot) ->

  robot.respond /lsf/i, (res) ->
    res.send "Learning for a Sustainable Future"
    res.send({"text":"http://lsf-lst.ca/", "unfurl_links": true})
    res.send "if you want to know more ask “real” Carlos"
    res.finish()
