const express = require('express');
const graphqlHTTP = require('express-graphql');

const app = express();

// Middleware
app.use('/graphql', graphqlHTTP({
  graphiql: true
}));

const PORT = 4000;
 
app.listen(PORT, ()=>{
  console.log(`Listening for requests on port ${PORT}`);
});