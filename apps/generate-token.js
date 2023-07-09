const crypto = require('crypto');

const randomString1 = crypto.randomBytes(100).toString('hex');
console.log(randomString1);