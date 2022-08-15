const {GraphQLObjectType, GraphQLID, GraphQLString, GraphQLInt, GraphQLSchema, GraphQLBoolean, GraphQLList, GraphQLNonNull} = require('graphql');
var _ = require('lodash');

const User = require('../models/user');
const Hobby = require('../models/hobby');
const Post = require('../models/post');

// dummy data
// var userData = [
//   {id: '1', name: 'Bond', age: 36, profession: 'Programmer',},
//   {id: '13', name: 'Anna', age: 26, profession: 'Baker',},
//   {id: '211', name: 'Bella', age: 16, profession: 'Mechanic',},
//   {id: '19', name: 'Gina', age: 26, profession: 'Painter',},
//   {id: '150', name: 'Georgina', age: 36, profession: 'Teacher'},
// ];

// var hobbiesData = [
//   {id: '1', title: 'Programming', description: 'Using computers to make the world a better place', userId: '150',},
//   {id: '2', title: 'Rowing', description: 'Sweat and feel better before eating donoughts', userId: '19',},
//   {id: '3', title: 'Swimming', description: 'Get in the ware and learn to become the water', userId: '1',},
//   {id: '4', title: 'Fencing', description: 'A hobby for fency people', userId: '150',},
//   {id: '5', title: 'Programming', description: 'Wear hiking boots and explore the world', userId: '1',},
// ];

// var postsData = [
//   {id: '1', comment: 'Building a Mind', userId: '1'},
//   {id: '2', comment: 'GraphQL is Amazing', userId: '1'},
//   {id: '3', comment: 'How to Change the World', userId: '19'},
//   {id: '4', comment: 'How to Change the World', userId: '211'},
//   {id: '5', comment: 'How to Change the World', userId: '1'},
// ];

// TypeDefs
const UserType = new GraphQLObjectType({
  name: 'User',
  description: 'Documentation for user...',
  fields: () => ({
    id: {type: GraphQLString},
    name: {type: GraphQLString},
    age: {type: GraphQLInt},
    profession: {type: GraphQLString},
    
    posts:{
      type: new GraphQLList(PostType),
      resolve(parent, args){
        return Post.find({userId: parent.id});
      }
    },
    
    hobbies:{
      type: new GraphQLList(HobbyType),
      resolve(parent, args){
        return Hobby.find({userId: parent.id});
      }
    }
  })
});

const HobbyType = new GraphQLObjectType({
  name: 'Hobby',
  description: 'Hobby Description',
  fields: () => ({
    id: {type: GraphQLID},
    title: {type: GraphQLString},
    description: {type: GraphQLString},
    userId: { type: new GraphQLNonNull(GraphQLString)},
    user: {
      type: UserType,
      resolve(parent, args){
        return User.findById(parent.userId);
      }
    },
  })
});

const PostType = new GraphQLObjectType({
  name: 'Post',
  description: 'Post description',
  fields: () => ({
    id: {type: GraphQLID},
    comment: {type: GraphQLString},
    userId: { type: new GraphQLNonNull(GraphQLString)},
    user: {
      type: UserType,
      resolve(parent, args){
        return User.findById(parent.userId);
      }
    },
  })
});

// RootQuery
const RootQuery = new GraphQLObjectType({
  name: 'RootQueryType',
  description: 'Description',
  fields: {
    
    users:{
      type: new GraphQLList(UserType),
      resolve(parent, args){
        return User.find({});
      }
    },
    
    user:{
      type: UserType,
      args: {id: {type: GraphQLString}},
      resolve(parent, args){
        return User.findById(args.id)
      }
    },
    
    hobbies:{
      type: new GraphQLList(HobbyType),
      resolve(parent, args){
        return Hobby.find({});
      }
    },
    
    hobby:{
      type: HobbyType,
      args: {id: {type: GraphQLID}},
      resolve(parent, args){
        return Hobby.find({ id: args.userId });
      }
    },
    
    posts:{
      type: new GraphQLList(PostType),
      resolve(parent, args){
        return Post.find({});
      }
    },
    
    post:{
      type: PostType,
      args: {id: {type: GraphQLID}},
      resolve(parent, args){
        return Post.findById(args.id);
      }
    },
    
  }
});

// Mutations
const Mutation = new GraphQLObjectType({
  name: 'Mutation',
  fields: {
    
    createUser: {
      type: UserType,
      args: {
        name: {type: new GraphQLNonNull(GraphQLString)},
        age: {type: new GraphQLNonNull(GraphQLInt)},
        profession: {type: GraphQLString},
      },
      resolve(parent, args){
        let user = User({
          name: args.name,
          age: args.age,
          profession: args.profession
        });
        return user.save();
      }
    },
    
    // Update User
    UpdateUser:{
      type: UserType,
      args: {
        id: {type: new GraphQLNonNull(GraphQLString)},
        name: {type: new GraphQLNonNull(GraphQLString)},
        age: {type: new GraphQLNonNull(GraphQLInt)},
        profession: {type: GraphQLString},
      },
      resolve(parent, args){
        return updateUser = User.findByIdAndUpdate(
          args.id,
          {
            $set:{
              name: args.name,
              age: args.age,
              profession: args.profession,
            },
          },
          {new: true},
        );
      }
    },
    
    RemoveUser:{
      type: UserType,
      args: {
        id: {type: new GraphQLNonNull(GraphQLString)},
      },
      resolve(parent,args){
        let removedUser = User.findByIdAndRemove(args.id).exec();
        if(!removedUser){
          throw new "Error" ()
        }
        return removedUser;
      }
    },
    
    createPost: {
      type: PostType,
      args: {
        // id: {type: GraphQLID},
        comment: {type: new GraphQLNonNull(GraphQLString)},
        userId: {type: new GraphQLNonNull(GraphQLID)},
      },
      resolve(parent, args){
        let post = Post({
          comment: args.comment,
          userId: args.userId,
        })
        return post.save();
      }
    },
    
    UpdatePost:{
      type: PostType,
      args:{
        id: {type: new GraphQLNonNull(GraphQLString)},
        comment: {type: new GraphQLNonNull(GraphQLString)},
      },
      resolve(parent, args){
        return (updatedPost = Post.findByIdAndUpdate(
          args.id,
          {
            $set: {
              comment: args.comment
            }
          },
          {new: true}
        ))
      }
    },
    
    RemovePost:{
      type: PostType,
      args: {
        id: {type: new GraphQLNonNull(GraphQLString)},
      },
      resolve(parent,args){
        let removedPost = Post.findByIdAndRemove(args.id).exec();
        if(!removedPost){
          throw new "Error" ()
        }
        return removedPost;
      }
    },
    
    RemovePosts:{
      type: PostType,
      args: {
        ids: {type: GraphQLList(GraphQLString)},
      },
      resolve(parent, args){
        let removedPosts = Post.deleteMany({_id: args.ids}).exec();
        if(!removedPosts){
          throw new "Error" ()
        }
        return removedPosts
      }
    },
    
    createHobby: {
      type: HobbyType,
      args: {
        // id: {type: GraphQLID},
        title: {type: new GraphQLNonNull(GraphQLString)},
        description: {type:  new GraphQLNonNull(GraphQLString)},
        userId: {type: new GraphQLNonNull(GraphQLID)}
      },
      resolve(parent, args){
        let hobby = Hobby({
          title: args.title,
          description: args.description,
          userId: args.userId,
        });
        return hobby.save();
      }
    },
    
    UpdateHobby:{
      type: HobbyType,
      args:{
        id: {type: new GraphQLNonNull(GraphQLString)},
        title: {type: new GraphQLNonNull(GraphQLString)},
        description: {type: new GraphQLNonNull(GraphQLString)},
      },
      resolve(parent, args){
        return (updatedHobby = Hobby.findByIdAndUpdate(
          args.id,
          {
            $set: {
              title: args.comment,
              description: args.description
            }
          },
          {new: true}
        ))
      }
    },
    
    RemoveHobby:{
      type: HobbyType,
      args: {
        id: {type: new GraphQLNonNull(GraphQLString)},
      },
      resolve(parent,args){
        let removedHobby = Hobby.findByIdAndRemove(args.id).exec();
        if(!removedHobby){
          throw new "Error" ()
        }
        return removedHobby;
      }
    },
    
    RemoveHobbies:{
      type: HobbyType,
      args: {
        ids: {type: GraphQLList(GraphQLString)},
      },
      resolve(parent, args){
        let removedHobbies = Hobby.deleteMany({_id: args.ids}).exec();
        if(!removedHobbies){
          throw new "Error" ()
        }
        return removedHobbies
      }
    },
    
  }
});

const schema = new GraphQLSchema({
  query: RootQuery,
  mutation: Mutation
})

module.exports = schema;