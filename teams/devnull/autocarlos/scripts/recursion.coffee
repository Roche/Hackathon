
Conversation = require('hubot-conversation');

recursion = (res,switchBoard) ->
  res.send 'Did you mean: recursion?'
  dialog = switchBoard.startDialog(res)
  dialog.addChoice /yes/i, (msg2) -> 
    recursion(msg2,switchBoard)
    msg2.finish()
  dialog.addChoice /(.*)/i, (msg2) -> res.finish()
  res.finish()

module.exports = (robot) ->

  switchBoard = new Conversation(robot);

  robot.respond /what is recursion/i, (res) ->
    dialog = switchBoard.startDialog(res)
    recursion(res,switchBoard)
