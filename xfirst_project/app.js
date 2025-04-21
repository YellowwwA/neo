const express = require('express');
const axios = require('axios');
const CircularJSON = require('circular-json');
const app = express();

app.get('/', (req, res) => {
    res.send("Web Server Started...");
})

app.get('/r_getkidsacc', (req, res) => {
    res.send({data : 'GETKIDSACC Success!!'});
})

let option1 = 'http://192.168.1.40:3000/r_getkidsacc';
app.get('/kidsAccident', async (req, res) => {
    try {
      const response = await axios.get('http://192.168.1.40:3000/r_getkidsacc',  {
        params: { year, region },
      });
      console.log(response.data);  // 콘솔에 찍기
      res.send(response.data);     // 프론트로 보내기
    } catch (error) {
      console.error(error);
      res.status(500).send('오류 발생');
    }
  });
  
app.listen(8000, function() {
    console.log("Server is started~!! - Port : 8000");
});
