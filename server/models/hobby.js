const mongoose = require('mongoose');
const MSchema = mongoose.Schema

const hobbySchema = new MSchema({
  title: String,
  description: Number,
  profession: String,
  userId: Sting
});

module.exports = mongoose.model('Hobby', hobbySchema);