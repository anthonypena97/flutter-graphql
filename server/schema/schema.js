const {GraphQLObjectType, GraphQLID, GraphQLString, GraphQLInt, GraphQLSchema, buildSchema} = require('graphql');

// create types
const UserType = new GraphQLObjectType({
  name: 'User',
  description: 'Documentation for user...',
  fields: () => ({
    id: {type: GraphQLString},
    name: {type: GraphQLString},
    age: {type: GraphQLInt},
  })
});

// RootQuery
const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  description: 'Description',
  fields: {
    user:{
      type: UserType,
      args: {id: {type: GraphQLString}},
      
      resolve(parent, args){
        let user = {
          id: '345',
          age: 34,
          name: 'Paul'
        }
        
        return user;
        
        // we resolve with data
        // get and return data from a datasource
      }
    }
  }
});

const schema = new GraphQLSchema({
  query: RootQuery
})

module.exports = schema;