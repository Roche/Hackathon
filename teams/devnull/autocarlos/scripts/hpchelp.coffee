
module.exports = (robot) ->

  robot.respond /how do i submit a job/i, (res) ->
    res.reply 'create a script with the following contents'
    res.reply '```#!/bin/bash\n#SBATCH --job-name "Sequential test job"\n#SBATCH --ntasks 1\n#SBATCH --time 1-00:00\n#SBATCH --qos normal\n\n./sequential_example_application --with --params```'
    res.reply 'then run: `sbatch script.sh`'
    res.finish()
