const express = require('express');

const app = express();

const PORT = 3000;
 
app.listen(PORT, ()=>{
  console.log(`Listening for requests on port ${PORT}`);
});