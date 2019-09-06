Conversation = require('hubot-conversation');
module.exports = (robot) ->
 
  switchBoard = new Conversation(robot);

  robot.respond /jump/, (msg) ->
    dialog = switchBoard.startDialog(msg)
    msg.reply 'Sure, How many times?' 
    
    dialog.addChoice /([0-9]+)/i, (msg2) ->
        times = parseInt(msg2.match[1], 10)
        msg.emote "Jumps" for i in [0..times]
    msg.finish()

  robot.respond /my job is slow/, (msg) ->
    dialog = switchBoard.startDialog(msg)
    msg.reply 'Can you tell me the jobid?' 
    
    dialog.addChoice /([0-9]+)/i, (msg2) ->
        jobid = parseInt(msg2.match[1], 10)
        msg.emote "please check your job performace at http://grafana.marathon.bahpc.roche.com:3000/d/000000009/job-monitoring?orgId=1&var-jobid="+jobid 
    msg.finish()

  robot.respond /How (can|do) (I|we) get a (WS|workstation)/i, (res) -> 
   res.send "Linux Workstation"
   dialog = switchBoard.startDialog(res)
   res.send 'Do you whant to order a Workstation?' 
   dialog.addChoice /yes/i, (msg2) ->
        msg2.send 'How many Cores?'
        dialog.addChoice /([0-9]+)/i, (msg3) ->
          wsCores=msg3.match[0]
          msg3.send 'How much Memory in GB?'
          dialog.addChoice /([0-9]+)/i, (msg4) ->
            wsMem=msg4.match[0]
            msg4.send 'How much Disk space in GB?'
            dialog.addChoice /([0-9]+)/i, (msg5) ->
              wsDisk=msg5.match[0]
              msg5.send 'How much GPU (0,1 or 2)?'
              dialog.addChoice /([0-2])/i, (msg6) ->
                wsGPU=msg6.match[0]

                msg6.send 'You are ordering a workstation with  '+wsCores+' cores, '+wsMem+'GB RAM, '+wsDisk+'GB Disk and '+wsGPU+' GPU  is that correct?'
          
                dialog.addChoice /yes/i, (msg22) ->
                  msg22.send 'Your request has been submitted. Ticket ID: SCICOMP-'+msg4.random [1..5000]
   dialog.addChoice /no/i, (msg2) ->
     msg2.send 'Thanks for asking'
   res.finish()


  robot.respond /^How (can|do) (i|we) get more inodes/i, (res) ->
    res.send "Open a ticket on SCICOMP JIRA"
    dialog = switchBoard.startDialog(res)
    res.send 'Would you like to open a ticket now?' 
    dialog.addChoice /yes/i, (msg2) ->
      msg2.send 'Which data area would you like to extend?'
      dialog.addChoice /(rpm*)/i, (msg3) ->
        msg3.send 'Thanks for asking'
      dialog.addChoice /(.*)/i, (msg3) ->
        msg3.send 'How many more inodes would you like to add to '+msg3.match[1]+'?'
        dialog.addChoice /([0-9]+)/i, (msg4) ->
          msg4.send 'Your request has been submitted. Ticket ID: SCICOMP-'+msg4.random [1..5000]
    dialog.addChoice /no/i, (msg2) ->
      msg.send 'too bad'
    res.finish()
    

  robot.respond /network/i, (res) ->
    res.send "Network status report"
    dialog = switchBoard.startDialog(res)
    res.send 'Do you want to see the network graf?'
    dialog.addChoice /yes/i, (msg2) ->
      msg2.send 'use the following command : @autocarlos graf db knet'
    res.finish()
   
