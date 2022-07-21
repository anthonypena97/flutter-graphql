const {GraphQLObjectType, GraphQLID, GraphQLString, GraphQLInt} = require('graphql');

// create types
const UserType = new GraphQLObjectType({
  name: 'User',
  description: 'Documentation for user...',
  fields: () => ({
    id: {type: GraphQLID},
    name: {type: GraphQLString},
    age: {type: GraphQLInt},
  })
})