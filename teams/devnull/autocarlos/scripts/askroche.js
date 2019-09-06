
const googleIt = require("google-it");
module.exports = function(robot){

  robot.respond(/tell me about (.*) at roche/i, function(res){
    
    googleIt({'query': 'site:roche.com '+res.match[1]}).then(results => {
      res.reply(results[0]['link']);
    }).catch(e => {
      res.reply("There was an issue with your request")
    });
    res.finish()
  });

  robot.respond(/tell us about (.*) at roche/i, function(res){
    
    googleIt({'query': 'site: roche.com '+res.match[1]}).then(results => {
      res.send({"text":results[0]['link'], "unfurl_links": true});
    }).catch(e => {
      res.send("There was an issue with your request")
    });
    res.finish()
  });
  robot.respond(/tell me about (.*)/i, function(res){
    
    googleIt({'query': res.match[1]}).then(results => {
      res.reply(results[0]['link']);
    }).catch(e => {
      res.reply("There was an issue with your request")
    });
    res.finish()
  });

  robot.respond(/tell us about (.*)/i, function(res){
    
    googleIt({'query': res.match[1]}).then(results => {
      res.send({"text":results[0]['link'], "unfurl_links": true});
    }).catch(e => {
      res.send("There was an issue with your request")
    });
    res.finish()
  });

}
