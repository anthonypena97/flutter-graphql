const {GraphQLObjectType, GraphQLID, GraphQLString, GraphQLInt, GraphQLSchema, buildSchema, GraphQLBoolean} = require('graphql');
var _ = require('lodash');

// dummy data
var userData = [
  {id: '1', name: 'Bond', age: 36, profession: 'Programmer',},
  {id: '13', name: 'Anna', age: 26, profession: 'Baker',},
  {id: '211', name: 'Bella', age: 16, profession: 'Mechanic',},
  {id: '19', name: 'Gina', age: 26, profession: 'Painter',},
  {id: '150', name: 'Georgina', age: 36, profession: 'Teacher'},
];

var hobbyData = [
  {id: '1', title: 'Programming', description: 'Using computers to make the world a better place',},
  {id: '2', title: 'Rowing', description: 'Sweat and feel better before eating donoughts',},
  {id: '3', title: 'Swimming', description: 'Get in the ware and learn to become the water',},
  {id: '4', title: 'Fencing', description: 'A hobby for fency people',},
  {id: '5', title: 'Programming', description: 'Wear hiking boots and explore the world',},
  
];

// create types
const UserType = new GraphQLObjectType({
  name: 'User',
  description: 'Documentation for user...',
  fields: () => ({
    id: {type: GraphQLString},
    name: {type: GraphQLString},
    age: {type: GraphQLInt},
    profession: {type: GraphQLString}
  })
});

const HobbyType = new GraphQLObjectType({
  name: 'Hobby',
  description: 'Hobby Description',
  fields: () => ({
    id: {type: GraphQLID},
    title: {type: GraphQLString},
    description: {type: GraphQLString}
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
       
        return _.find(userData, {id: args.id});
        
        // we resolve with data
        // get and return data from a datasource
      }
    },
    
    hobby:{
      type: HobbyType,
      args: {id: {type: GraphQLID}},
      
      resolve(parent, args){
        
        return _.find(hobbyData, {id: args.id});
        
      }
    }
  }
});

const schema = new GraphQLSchema({
  query: RootQuery
})

module.exports = schema;