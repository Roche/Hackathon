
module.exports = (robot) ->

  robot.respond /help/i, (res) ->
    res.reply """Available commands:
```
lsf
tell me about SOMETHING at roche
how do i submit a job
jump
my job is slow
How can i get a workstation
How (can|do) (I|we) get more inodes?
make me a sandwich
sudo make me a sandwich
how do I get a macbook?
where is my data?
Which text editor should I use?
what is the answer to the ultimate question of life?
```
"""
    res.finish()
