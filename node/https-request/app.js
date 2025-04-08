const https = require('http');

const data = JSON.stringify({todo : 'Buy the miilk - Moon'});

const options = {
    hostname : '192.168.1.40',
    port: 8000,
    path: '/data',
    method: 'GET',
};

const req = https.request(options, res => {
    console.log(`statusCode: ${res.statusCode}`);
    res.on('data', d => {
        process.stdout.write(d);
    });
});

req.on('error', error => {
    console.error(error);
});

req.write(data);
req.end();