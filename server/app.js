const dotenv = require('dotenv')
console.log(process.env) 

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

// console.log(process.env.MONGO_USERNAME)

mongoose.connect(`mongodb+srv://anthonypena97:<password>@graphqlcluster.6k90h.mongodb.net/?retryWrites=true&w=majority`)
 
app.listen(PORT, ()=>{
  console.log(`Listening for requests on port ${PORT}`);
});