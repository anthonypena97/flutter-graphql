const mongoose = require('mongoose');
const MSchema = mongoose.Schema;
mongoose.set('useFindAndModify', false);

const postSchema = new MSchema({
  comment: String,
});

module.exports = mongoose.model('Post', postSchema);