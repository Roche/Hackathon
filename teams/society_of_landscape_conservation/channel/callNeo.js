async function action(bp: typeof sdk, event: sdk.IO.IncomingEvent, args: any, { user, temp, session } = event.state){
  /** Your code starts below */
  
  const axios = require('axios')
  
    /**
     * @title Call the Github API to fetch Botpress repositories
     * @category Hackathon
     * @author Daniel Butnaru
     */
    const callApi = async () => {
      // We call the Github API
      const { data } = await axios.post('http://docker.for.win.localhost:33333/questions', {
        question: args['text']
      })
  
      // We assign the response to the session variable so we can use it later
      temp.response = data
    }
  
    // Actions are async, so make sure to return a promise
    return callApi()
  /** Your code ends here */
  }