const axios = require('axios')

getSentence = async () => {
    const jokeData = await axios.get('https://favqs.com/api/qotd');
    return jokeData.data.quote.body.split(' ')
}

module.exports = getSentence;