const express = require('express');

const app = express();

app.use(express.json());
app.listen(8004, () => {
    console.log('Server is running at port 8004');
})