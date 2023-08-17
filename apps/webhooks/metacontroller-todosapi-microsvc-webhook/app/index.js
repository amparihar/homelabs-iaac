const express = require('express'),
    cors = require('cors');

const app = express();
app.set("port", 8001);
app.use(cors());
app.use(express.json());

app.post('/sync', (req, res, next) => {
    let syncHookReq = req.body.request,
        parent = syncHookReq.parent,
        children = syncHookReq.children;

    console.log(JSON.stringify(parent));
    console.log(JSON.stringify(children));

    let desired_status = {
        "pods": Object.keys(children["Pod.v1"]).length
    };

    let desired_pods = {};

    res.status(200).send({ "status": desired_status, "children": desired_pods });

});


app.listen(app.get("port"), function() {
    console.log("meta controller sync started on port " + app.get("port"));
});