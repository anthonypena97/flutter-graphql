const mongoose = require('mongoose');
const MSchema = mongoose.Schema

const hobbySchema = new MSchema({
  title: String,
  description: Number,
  profession: String,
});

module.exports = mongoose.model('Hobby', hobbySchema);