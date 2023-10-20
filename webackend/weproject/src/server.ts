import express from 'express'
import payload from 'payload'
import bodyParser from 'body-parser';

require('dotenv').config()
const app = express();

// configure the app to use bodyParser()
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

// Redirect root to Admin panel
app.get('/', (_, res) => {
  res.redirect('/admin')
});


const start = async () => {
  // Initialize Payload
  await payload.init({
    secret: process.env.PAYLOAD_SECRET,
    express: app
  });

  app.post("/create-user",async(req,res)=>{
    const { fullName, email, password } = req.body;
   // console.log(req.body);
    try {
      const post = await payload.create({
        collection: 'users',
        data: {
          fullName: fullName,
          email: email,
          password: password,
        }
      });
      //console.log(post);
      if(post)
        return res.status(200).json(post);

    } catch (error) {
      console.log(error);
      return res.status(400).json({ errors: error});
    }    
  });

  app.post("/login", async (req,res)=>{
    const { userName, password } = req.body;
    console.log(req.body);
    try {
      const post = await payload.login({
        collection: 'users',
        data: {
          email: userName,
          password: password,
        }
      });
      console.log(post);
      if(post)
        return res.status(200).json(post);

    } catch (error) {
      console.log(error);
      return res.status(400).json({ errors: error});
    }   
  });

  app.listen(3000)
}

start()