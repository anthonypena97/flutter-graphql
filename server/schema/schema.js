const {GraphQLObjectType, GraphQLID, GraphQLString, GraphQLInt, GraphQLSchema} = require('graphql');

// create types
const UserType = new GraphQLObjectType({
  name: 'User',
  description: 'Documentation for user...',
  fields: () => ({
    id: {type: GraphQLString},
    name: {type: GraphQLString},
    age: {type: GraphQLInt},
  })
})

// RootQuery
const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  description: 'Description',
  fields: {
    user:{
      type: UserType,
      args: {id: {type: GraphQLString}},
      
      resolve(parent, args){
        // we resolve with data
        // get and return data from a datasource
      }
    }
  }
});

module.export = new GraphQLSchema({
  query: RootQuery
})