const express = require('express');
const {graphqlHTTP} = require('express-graphql');
const {buildSchema} = require('graphql');

const schema = require('./schema/schema');

const app = express();

// Middleware
app.use('/graphql', graphqlHTTP({
  schema: schema,
  graphiql: true,
  pretty: true,
}));

const PORT = 4000;
 
app.listen(PORT, ()=>{
  console.log(`Listening for requests on port ${PORT}`);
});