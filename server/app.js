require('dotenv').config()

const express = require('express');
const {graphqlHTTP} = require('express-graphql');

const schema = require('./schema/schema');

const mongoose = require('mongoose');

const app = express();

// Middleware
app.use('/graphql', graphqlHTTP({
  schema: schema,
  graphiql: true,
  pretty: true,
}));

const PORT = 4000;

mongoose.connect(`mongodb+srv://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@graphqlcluster.6k90h.mongodb.net/?retryWrites=true&w=majority`)
 
app.listen(PORT, ()=>{
  console.log(`Listening for requests on port ${PORT}`);
});