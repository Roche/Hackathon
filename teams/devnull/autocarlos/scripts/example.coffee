# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.respond /how do I get a mac( ?book)?/i, (res) ->
    res.send "Talk to Mischa Huber mischa.huber@roche.com"
    res.finish()
  robot.respond /where is my data/i, (res) ->
    res.send "https://www.youtube.com/watch?v=gDfLXAtRJfY"
    res.finish()
  robot.respond /what is the answer to the ultimate question of life/, (res) ->
    res.send "It used to be 42, but since the Foxtrail it is now 400!"
    res.finish()
    
