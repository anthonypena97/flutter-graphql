require('dotenv').config()

const cors = require('cors');

const express = require('express');
const {graphqlHTTP} = require('express-graphql');

const schema = require('./schema/schema');

const mongoose = require('mongoose');

const app = express();

// Middleware
app.use(cors());
app.use('/graphql', graphqlHTTP({
  schema: schema,
  graphiql: true,
  pretty: true,
}));

const PORT = process.env.PORT || 4000;

mongoose.connect(`mongodb+srv://${process.env.MONGO_USERNAME}:${process.env.MONGO_PASSWORD}@graphqlcluster.6k90h.mongodb.net/${process.env.MONGO_DATABASE}?retryWrites=true&w=majority`, {useNewUrlParser: true, useUnifiedTopology: true})
.then(() =>{
  app.listen(PORT, ()=>{
    console.log(`Listening for requests on port ${PORT}`);
  });
  
})
.catch((e)=>{console.log(`Error ::: ${e}`)})